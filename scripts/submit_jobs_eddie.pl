$samplesheet = shift;

open (SAMPLESHEET, "$samplesheet") or die "Cannot open uploaded $samplesheet. Try again.\n";
while(<SAMPLESHEET>){
	chomp $_;
	@words = split("\t", $_);
	$sample = $words[0];

	open (SH, ">pipeline/$sample.sh") or die "Cannot create pipeline/$sample.sh\n";
	print SH "\#!/bin/sh\n\n";
	print SH "\#\$ -o pipeline/$sample.out\n";
	print SH "\#\$ -j y\n";
	print SH "\#\$ -N N$sample\n";
	print SH "\#\$ -cwd\n";

	print SH "\#\$ -l h_rt=24:00:00\n";
	print SH "\#\$ -l h_vmem=4G\n\n";

	print SH "source ~/.bash_profile\n\n";
	print SH "source activate mhc\n\n";

	print SH "snakemake --nolock --config samples=S$sample -p -j 1\n";
	close (SH);
	system ("qsub pipeline/$sample.sh");
	# }
}
