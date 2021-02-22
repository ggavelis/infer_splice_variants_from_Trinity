#!/usr/bin/python

#from Bio import SeqIO
import numpy as np; import pandas as pd; import os.path; from os import path; import sys

library=sys.argv[1]
basedir='/scratch/brown/ggavelis/all_dinos/'
tsvdir='/scratch/brown/ggavelis/all_dinos/supertsv/'
outdir=tsvdir +'with_splice_isoforms/'
supertsv_file = tsvdir + library + '_pep_cds_transcript_metrics.tsv'

splice_dict={}; isoform_dict={}; prev_gene=''; gene=''
ghost_dict, kegg_dict, ips_dict, ai_dict, super_dict = {}, {}, {}, {}, {}
count,ips_lines,annot_count,previous_accession = 0,0,0,''

    
##################### PART I: FIND ALL FILES ***********************###
    
print('\n******** ' + library + ' *******\n')
    
if not path.exists(supertsv_file):   ## Check for supertsv file
    print('no supertsv for ' + library)
super_df = pd.read_csv(supertsv_file, delimiter='\t', dtype=str) #{"Core_SeqID":str, "Pep_ID":str, "Pep_seq":str, "CDS_ID":str, "CDS_seq":str, "Transcript_ID":str, "Transcript_seq":str, "AA_length":str, "5prime_methionine":str, "Third_codon_GC_usage":int, "Dinoflagellate_spliced_leader":str, "Polyadenylated":str, "SplicingVariantOfThisGene":str, "ORFofThisTranscript":str, "NewProteinID":str})

for index, row in super_df.iterrows():
    count +=1
    query=row['NewProteinID'].replace('>','')
    gene=row['SplicingVariantOfThisGene']
    if count > 1:
        if gene != prev_gene:
            prev_gene = gene
            splice_dict[prev_gene] = 1             
        else:
            splice_dict[prev_gene] = splice_dict[prev_gene]+1
            #print(str(splice_dict[prev_gene]))
        
print('done with first pass')
print(str(len(splice_dict)) + ' core genes in total')
print('with ' + str(count) + ' splice isoforms in total')
        
        
########## PART II: Adding the number of splice variants back into the supertsv ##################

super_df['NumSpliceVariants'] = 1; count = 0
        
for row in super_df.index:
    count += 1
    key = super_df.loc[row,'SplicingVariantOfThisGene']
    if key in splice_dict:
        value = splice_dict.get(key)
        super_df.loc[row, 'NumSpliceVariants'] = value
        print(str(count))

super_df.to_csv(outdir + library + '_pep_cds_transcript_metrics.tsv', sep='\t')
               
print('done')