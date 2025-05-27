use Getopt::Long;
use Cwd;

my $samplesheet = "samplesheet.txt";
my $work_dir    = "results";
my $prefix      = "run";
my $cutoff      = 0.2;
my $fc          = 3;

GetOptions(
    'samplesheet=s' => \$samplesheet,
    'work_dir=s'    => \$work_dir,
    'database=s'  => \$database,
    'prefix=s'      => \$prefix
) or print "Invalid options\n";


print "=> Apply overlap_mhcI.pl on samples ...\n";
open (SAMPLESHEET, "$samplesheet") or die "Cannot open uploaded $samplesheet. Try again.\n";
while(<SAMPLESHEET>){
	chomp $_;
	@words = split("\t", $_);
	$sample = $words[0];
	print "==> Running $sample...\n";
    print "===> CMD: perl scripts/overlap_mhcI.pl \\
        --sample=$sample \\
        --primer1=results/$sample/06-filtering/$sample.For1Rev2.selected.fasta \\
        --primer2=results/$sample/06-filtering/$sample.For3Rev1.selected.fasta\n\n";
	system ("
        perl scripts/overlap_mhcI.pl \\
            --sample=$sample \\
            --primer1=results/$sample/06-filtering/$sample.For1Rev2.selected.fasta \\
            --primer2=results/$sample/06-filtering/$sample.For1Rev2.selected.fasta");
    print "===> DONE $sample\n\n";
}
print "=> Apply overlap_mhcI.pl on samples ... Done \n\n\n";


print "=> Running makeSummaryOverlappedPrimers.pl\n";
print "==> Running $sample...\n";
print "===> CMD: perl scripts/makeSummaryOverlappedPrimers.pl \\
    --samplesheet=$samplesheet \\
    --prefix=$prefix \\
    --cutoff=$cutoff \\
    --database=$database \\
    --fc=$fc\n\n";
system ("perl scripts/makeSummaryOverlappedPrimers.pl \\
    --samplesheet=$samplesheet \\
    --prefix=$prefix \\
    --cutoff=$cutoff \\
    --database=$database \\
    --fc=$fc");
print "===> DONE\n\n";


system ("cat summary/*.mhcI.selected.tsv > $prefix.mhcI.selected.tsv");
system ("cat summary/*.mhcI.discarded.tsv > $prefix.mhcI.discarded.tsv");
system ("cat summary/*.mhcI.nc.tsv > $prefix.mhcI.nc.tsv");

