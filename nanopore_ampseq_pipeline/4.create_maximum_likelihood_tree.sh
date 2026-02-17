# To begin, make a consensus fasta file for the region that you want to plot for your phylogenetic tree
# For example, SINE200 for Anopheles, or mitochondrial markers for Plasmodium
# You will need to make a bedfile with the region(s) you want to create consensus fasta files for

# Minimum package requirements

conda create -n phylo_env -c bioconda -c conda-forge \
    mafft raxml-ng samtools bcftools bedtools whatshap clair3 -y
conda activate phylo_env

# Or this is faster using mamba to download!

mamba create -n phylo_env -c bioconda -c conda-forge \
    mafft raxml-ng samtools bcftools bedtools whatshap clair3 -y
conda activate phylo_env


# Create the consensus fasta files using /gitrepos/smoss_ampseq/nanopore_ampseq_pipeline/consensus_amplicon_fastas_loop.sh

# Then make the phylogenetic tree. For example:

# 1. Align the consensus fasta file (eg. using Aliview on your computer or using mafft)

# Used mafft to align (save as .afa for 'aligned fasta file')

mafft --auto coluzzii_consensus_mitochondria.fasta > coluzzii_consensus_mitochondria.afa

# Inspect the alignment (e.g., check for obvious truncations/frameshifts/long Ns) before creating the tree.

# Create the phylogenetic tree using RAxML

raxml-ng --all --msa coluzzii_consensus_mitochondria.afa \
         --msa-format FASTA \
         --model GTR \
         --prefix Anopheles_coluzzii_mito \
         --seed 826482 \
         --bs-metric tbe \
         --tree rand{1} \
         --bs-trees 1000      #1000 bootstrap replicates

# Use best_tree for iTOL (*.raxml.bestTree)
# Use https://itol.embl.de/ to upload and plot this tree. 
# Note that if you do not have a paid account it won't save your edits, so do all in one go and download, or pay for an account.