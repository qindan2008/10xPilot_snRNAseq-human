#!/bin/bash
#$ -cwd
#$ -l mem_free=30G,h_vmem=30G,h_fsize=100G
#$ -pe local 1
#$ -N munge_gwas
#$ -o logs/munge-gwas_$JOB_ID.txt
#$ -e logs/munge-gwas_$JOB_ID_err.txt

echo "**** Job starts ****"
date
echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${TASK_ID}"

module load conda/3-4.6.14
module load git

## List current modules
module list

if [ -d "ldsc/" ]
then
    echo "LDSC exists. Reformatting GWAS..."
    cd ldsc/
    mkdir -p ../clean_gwas/munge_gwas/
    conda activate ldsc
    ./munge_sumstats.py --sumstats ../clean_gwas/AgeofInitiation_Clean_hg38.txt --out ../clean_gwas/munge_gwas/AgeofInitiation_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/CigarettesPerDay_Clean_hg38.txt --out ../clean_gwas/munge_gwas/CigarettesPerDay_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/DrinksPerWeek_Clean_hg38.txt --out ../clean_gwas/munge_gwas/DrinksPerWeek_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/SmokingCessation_Clean_hg38.txt --out ../clean_gwas/munge_gwas/SmokingCessation_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/SmokingInitiation_Clean_hg38.txt --out ../clean_gwas/munge_gwas/SmokingInitiation_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
else
    echo "No LDSC/, Git cloning it now. Using Python 2.7..."
    git clone https://github.com/bulik/ldsc.git
    cd ldsc

    conda env create --name ldsc python=2.7 --file environment.yml
    conda activate ldsc

    echo "Reformatting GWAS..."
    mkdir -p ../clean_gwas/munge_gwas/
    ./munge_sumstats.py --sumstats ../clean_gwas/AgeofInitiation_Clean_hg38.txt --out ../clean_gwas/munge_gwas/AgeofInitiation_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/CigarettesPerDay_Clean_hg38.txt --out ../clean_gwas/munge_gwas/CigarettesPerDay_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/DrinksPerWeek_Clean_hg38.txt --out ../clean_gwas/munge_gwas/DrinksPerWeek_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/SmokingCessation_Clean_hg38.txt --out ../clean_gwas/munge_gwas/SmokingCessation_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
    ./munge_sumstats.py --sumstats ../clean_gwas/SmokingInitiation_Clean_hg38.txt --out ../clean_gwas/munge_gwas/SmokingInitiation_hg19_munge.txt --a1 REF --a2 ALT --p PVALUE --snp RSID --nstudy Number_of_Studies
fi

echo "**** Job ends ****"
date
