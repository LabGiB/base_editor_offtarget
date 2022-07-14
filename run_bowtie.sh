
# Creation of conda environment
# conda create --name samtools_env -c conda-forge -c bioconda samtools bzip2 bcftools bowtie2 pysamstats

directories=(fastq_offtargets Fastq_13032022 Fastq_12042021)
# index_path=index/index
index_path=reference_index/GRCh38_index
results_dir=results_2

for dir in ${directories[@]}; do
    echo "-----------------------------------------------------"
    echo "Running bowtie2 for directory: $dir"
    for f1 in $dir/*_R1_001.fastq; do
        f2="${f1/_R1_/_R2_}"
        echo "Running bowtie for:"
        echo $f1
        echo $f2
        temp=${results_dir}/$(basename ${f1})
        sam="${temp/_L001_R1_001.fastq/.sam}"
        bam="${temp/_L001_R1_001.fastq/.bam}"
        sorted_bam="${temp/_L001_R1_001.fastq/.sorted.bam}"
        
        bowtie2 -p 24 --very-fast-local -x $index_path -1 $f1 -2 $f2 -S $sam
        samtools view -bS $sam > $bam
        samtools sort $bam -o $sorted_bam
        samtools index $sorted_bam
    done
done