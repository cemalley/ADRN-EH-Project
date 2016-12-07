
chr=$1

# If vcf.gz files are not already indexed:
#tabix -p vcf ADRN_${chr}.vcf.bgzf.gz

cd /dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/union

bcftools view -O v --regions-file ADNA.union.dpos.csv /dcl01/mathias/data/ADRN_EH/ADRN/ADRN_${chr}.vcf.bgzf.gz > ADNA.${chr}.damaging.union.vcf

bcftools view -O v --regions-file EH.union.dpos.csv /dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/EH.${chr}.snps.filtered.recode.vcf.gz > EH.${chr}.damaging.union.vcf
