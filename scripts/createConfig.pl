$in = shift;
$out = shift;
open(OUT, ">$out");

print OUT "read_quality_threshold: 28\n";
print OUT "read_trim_length_threshold: 150\n";
print OUT "maximum_overlap: 300\n";
print OUT "minimum_overlap: 20\n";
print OUT "amplicon_size:\n";
print OUT "  For1Rev2: 378\n";
print OUT "  For3Rev1: 318\n";
print OUT "  DRB3: 324\n";
print OUT "  DQA: 261\n";
print OUT "  DQB: 281\n";
print OUT "read_count_percent_threshold:\n";
print OUT "  For1Rev2: 0.2\n";
print OUT "  For3Rev1: 0.2\n";
print OUT "  DRB3: 5\n";
print OUT "  DQA: 7\n";
print OUT "  DQB: 3\n";
print OUT "fold_change_discarded:\n";
print OUT "  For1Rev2: 3\n";
print OUT "  For3Rev1: 3\n";
print OUT "  DRB3: 3\n";
print OUT "  DQA: 3\n";
print OUT "  DQB: 3\n";
print OUT "no_of_clusters: 1000\n";
print OUT "primers:\n";
print OUT "  For1Rev2: \"fasta/Bovine.For1Rev2.primers.fa\"\n";
print OUT "  For3Rev1: \"fasta/Bovine.For3Rev1.primers.fa\"\n";
print OUT "  DRB3: \"fasta/Bovine.DRB3.primers.fa\"\n";
print OUT "  DQA: \"fasta/Bovine.DQA.primers.fa\"\n";
print OUT "  DQB: \"fasta/Bovine.DQB.primers.fa\"\n";
print OUT "database:\n";
print OUT "  For1Rev2: \"fasta/Bovine.MHCI.fasta\"\n";
print OUT "  For3Rev1: \"fasta/Bovine.MHCI.fasta\"\n";
print OUT "  DRB3: \"fasta/Bovine.DRB3.fasta\"\n";
print OUT "  DQA: \"fasta/Bovine.DQA.fasta\"\n";
print OUT "  DQB: \"fasta/Bovine.DQB.fasta\"\n";
print OUT "samples:\n";

open(IN, "$in");
while(<IN>){
	chomp $_;
	$sample = $_;
	print OUT "  - S$sample\n";
}
print OUT "reads:\n";

open(IN, "$in");
while(<IN>){
	chomp $_;
	my $sample = $_;
	opendir my $dir, "fastq/$sample" or die "Cannot open directoru: $!";
	my @files = grep(/\_1.fastq.gz$/, readdir ($dir));
	print "$sample\t@files\n";
	closedir $dir;
	# my $read = <fastq/$sample/*1.fastq.gz>;
	# print "$sample\t$read\n";
	$read = $files[0];
	$read =~ s/_1.fastq.gz//g;
	# $read =~ s/fastq\///g;
	print OUT "  S$sample: \"$sample/$read\"\n";
	# $read = undef;
}






