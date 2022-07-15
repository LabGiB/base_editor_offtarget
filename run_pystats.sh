index=reference_index/GRCh38_latest_genomic.fna
dir=results_2

for f in $dir/*.sorted.bam; do
    echo "Running pysamstats for: $f"

    summary_statistics_file=$f.stats
    
    pysamstats --max-depth=100000 -t variation -f $index $f > $summary_statistics_file
done
