use Getopt::Long;
use Cwd;

my $samplesheet = "samples.txt";
my $prefix = "run";
my $primer = "DRB3";
my $cutoff = 2;

GetOptions(
    'samplesheet=s' => \$samplesheet,
    'prefix=s'      => \$prefix,
    'primer=s'      => \$primer,
    'cutoff=s'      => \$cutoff,
    'fc=i'          => \$fc,
) or print "Invalid options\n";

print "=> Sample Sheet: $samplesheet\n";

print "==> Running scripts/makeSummarySinglePrimers.pl\n";
print "===> CMD: perl scripts/makeSummarySinglePrimers.pl 
    --samplesheet=$samplesheet \\
    --prefix=$prefix \\
    --primer=$primer \\
    --cutoff=$cutoff \\
    --fc=$fc\n\n";
system ("
    perl scripts/makeSummarySinglePrimers.pl \\
        --samplesheet=$samplesheet \\
        --prefix=$prefix \\
        --primer=$primer \\
        --cutoff=$cutoff \\
        --fc=$fc");

print "==> cat .selected.tsv files\n";
system ("cat summary/*.$primer.selected.tsv > $prefix.$primer.selected.tsv");

print "==> cat .discarded.tsv files\n";
system ("cat summary/*.$primer.discarded.tsv > $prefix.$primer.discarded.tsv");
