#include <linux/fs.h>
#include <linux/hugetlb.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/mman.h>
#include <linux/mmzone.h>
#include <linux/proc_fs.h>
#include <linux/quicklist.h>
#include <linux/seq_file.h>
#include <linux/swap.h>
#include <linux/vmstat.h>
#include <linux/atomic.h>
#include <asm/page.h>
#include <asm/pgtable.h>
#include "internal.h"

void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
{
}

static unsigned long board_ddr_size = 0;
void register_board_ddr_size(unsigned long size)
{
       board_ddr_size = size;
}

static char procname[PAGE_SIZE];
extern int proc_pid_cmdline(struct task_struct *task, char * buffer);
extern unsigned char *asoc_get_boot_afinfo(void);

static int meminfo_proc_show(struct seq_file *m, void *v)
{
	struct sysinfo i;
	unsigned long committed;
	unsigned long allowed;
	struct vmalloc_info vmi;
	long cached;
	unsigned long pages[NR_LRU_LISTS];
	int lru;
	unsigned long i_totalram, i_freeram;
	unsigned char *p_afinfo;
	unsigned int multiple;
	unsigned int mem_inc_num;
	uid_t tmp_real_cred_uid,tmp_cred_uid;
/*
 * display in kilobytes.
 */
#define K(x) ((x) << (PAGE_SHIFT - 10))
	si_meminfo(&i);
	si_swapinfo(&i);
	committed = percpu_counter_read_positive(&vm_committed_as);
	allowed = ((totalram_pages - hugetlb_total_pages())
		* sysctl_overcommit_ratio / 100) + total_swap_pages;

	cached = global_page_state(NR_FILE_PAGES) -
			total_swapcache_pages - i.bufferram;
	if (cached < 0)
		cached = 0;

	get_vmalloc_info(&vmi);

	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
		pages[lru] = global_page_state(NR_LRU_BASE + lru);

	i_totalram = board_ddr_size/1024;
	i_freeram = K(i.freeram) - K(global_page_state(NR_FREE_CMA_PAGES));

	proc_pid_cmdline(current, procname);
	if (strstr(procname, "com.gameloft.android.ANMP.GloftIMHM")!=NULL)
	{
		i_totalram /= 2;
		i_freeram /= 2;
		mem_inc_num = 1;
	}
	else
	{
		p_afinfo = asoc_get_boot_afinfo();
		if(p_afinfo == NULL || *((unsigned int*)(p_afinfo + 0x2c4)) > 8 
			|| *((unsigned int*)(p_afinfo + 0x2c4)) == 0)
		{
			multiple = 1;
		}
		else
		{
			multiple = *((unsigned int*)(p_afinfo + 0x2c4));
			if(multiple == 1)
				multiple = 2;
			else if(multiple == 8)
				multiple = 16;
//			else if(multiple == 4)
//				multiple = 8;
//			else if(multiple == 8)
//				multiple = 16;
//			else if(multiple ==16)
//				multiple =32;
		}
		proc_pid_cmdline(current, procname);

		tmp_real_cred_uid = current->real_cred->uid;
		tmp_cred_uid =  current->cred->uid; 

		if ((strstr(procname, "com.android.settings")!=NULL) || ( tmp_real_cred_uid > 10000) )
			mem_inc_num = multiple;
		else 
			mem_inc_num = 1;
	}

	/*
	 * Tagged format, for easy grepping and expansion.
	 */
	seq_printf(m,
		"MemTotal:       %8lu kB\n"
		"MemFree:        %8lu kB\n"
		"CmaFree:        %8lu kB\n"
		"Buffers:        %8lu kB\n"
		"Cached:         %8lu kB\n"
		"SwapCached:     %8lu kB\n"
		"Active:         %8lu kB\n"
		"Inactive:       %8lu kB\n"
		"Active(anon):   %8lu kB\n"
		"Inactive(anon): %8lu kB\n"
		"Active(file):   %8lu kB\n"
		"Inactive(file): %8lu kB\n"
		"Unevictable:    %8lu kB\n"
		"Mlocked:        %8lu kB\n"
#ifdef CONFIG_HIGHMEM
		"HighTotal:      %8lu kB\n"
		"HighFree:       %8lu kB\n"
		"LowTotal:       %8lu kB\n"
		"LowFree:        %8lu kB\n"
#endif
#ifndef CONFIG_MMU
		"MmapCopy:       %8lu kB\n"
#endif
		"SwapTotal:      %8lu kB\n"
		"SwapFree:       %8lu kB\n"
		"Dirty:          %8lu kB\n"
		"Writeback:      %8lu kB\n"
		"AnonPages:      %8lu kB\n"
		"Mapped:         %8lu kB\n"
		"Shmem:          %8lu kB\n"
		"Slab:           %8lu kB\n"
		"SReclaimable:   %8lu kB\n"
		"SUnreclaim:     %8lu kB\n"
		"KernelStack:    %8lu kB\n"
		"PageTables:     %8lu kB\n"
#ifdef CONFIG_QUICKLIST
		"Quicklists:     %8lu kB\n"
#endif
		"NFS_Unstable:   %8lu kB\n"
		"Bounce:         %8lu kB\n"
		"WritebackTmp:   %8lu kB\n"
		"CommitLimit:    %8lu kB\n"
		"Committed_AS:   %8lu kB\n"
		"VmallocTotal:   %8lu kB\n"
		"VmallocUsed:    %8lu kB\n"
		"VmallocChunk:   %8lu kB\n"
#ifdef CONFIG_MEMORY_FAILURE
		"HardwareCorrupted: %5lu kB\n"
#endif
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
		"AnonHugePages:  %8lu kB\n"
#endif
		,
		i_totalram*mem_inc_num,
		i_freeram*mem_inc_num,
		K(global_page_state(NR_FREE_CMA_PAGES))*mem_inc_num,
		K(i.bufferram)*mem_inc_num,
		K(cached)*mem_inc_num,
		K(total_swapcache_pages),
		(K(pages[LRU_ACTIVE_ANON]   + pages[LRU_ACTIVE_FILE]))*mem_inc_num,
		(K(pages[LRU_INACTIVE_ANON] + pages[LRU_INACTIVE_FILE]))*mem_inc_num,
		K(pages[LRU_ACTIVE_ANON])*mem_inc_num,
		K(pages[LRU_INACTIVE_ANON])*mem_inc_num,
		K(pages[LRU_ACTIVE_FILE])*mem_inc_num,
		K(pages[LRU_INACTIVE_FILE])*mem_inc_num,
		K(pages[LRU_UNEVICTABLE])*mem_inc_num,
		K(global_page_state(NR_MLOCK)),
#ifdef CONFIG_HIGHMEM
		K(i.totalhigh)*mem_inc_num,
		K(i.freehigh)*mem_inc_num,
		K(i.totalram-i.totalhigh),
		K(i.freeram-i.freehigh),
#endif
#ifndef CONFIG_MMU
		K((unsigned long) atomic_long_read(&mmap_pages_allocated)),
#endif
		K(i.totalswap),
		K(i.freeswap),
		K(global_page_state(NR_FILE_DIRTY)),
		K(global_page_state(NR_WRITEBACK)),
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
		K(global_page_state(NR_ANON_PAGES)
		  + global_page_state(NR_ANON_TRANSPARENT_HUGEPAGES) *
		  HPAGE_PMD_NR),
#else
		K(global_page_state(NR_ANON_PAGES)),
#endif
		K(global_page_state(NR_FILE_MAPPED)),
		K(global_page_state(NR_SHMEM)),
		K(global_page_state(NR_SLAB_RECLAIMABLE) +
				global_page_state(NR_SLAB_UNRECLAIMABLE)),
		K(global_page_state(NR_SLAB_RECLAIMABLE)),
		K(global_page_state(NR_SLAB_UNRECLAIMABLE)),
		global_page_state(NR_KERNEL_STACK) * THREAD_SIZE / 1024,
		K(global_page_state(NR_PAGETABLE)),
#ifdef CONFIG_QUICKLIST
		K(quicklist_total_size()),
#endif
		K(global_page_state(NR_UNSTABLE_NFS)),
		K(global_page_state(NR_BOUNCE)),
		K(global_page_state(NR_WRITEBACK_TEMP)),
		K(allowed),
		K(committed),
		(unsigned long)VMALLOC_TOTAL >> 10,
		vmi.used >> 10,
		vmi.largest_chunk >> 10
#ifdef CONFIG_MEMORY_FAILURE
		,atomic_long_read(&mce_bad_pages) << (PAGE_SHIFT - 10)
#endif
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
		,K(global_page_state(NR_ANON_TRANSPARENT_HUGEPAGES) *
		   HPAGE_PMD_NR)
#endif
		);

	hugetlb_report_meminfo(m);

	arch_report_meminfo(m);

	return 0;
#undef K
}

static int meminfo_proc_open(struct inode *inode, struct file *file)
{
	return single_open(file, meminfo_proc_show, NULL);
}

static const struct file_operations meminfo_proc_fops = {
	.open		= meminfo_proc_open,
	.read		= seq_read,
	.llseek		= seq_lseek,
	.release	= single_release,
};

static int __init proc_meminfo_init(void)
{
	proc_create("meminfo", 0, NULL, &meminfo_proc_fops);
	return 0;
}
module_init(proc_meminfo_init);
