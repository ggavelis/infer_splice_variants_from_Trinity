#!/usr/bin/bash
set -e

libs=( \
# Alexandrium_tamarense_MMETSP4 \
Amphidinium_carterae_MMETSP4 \
Amphidinium_massartii_MMETSP \
Amyloodinium_ocellatum0_SRA \
Ansanella_granifera0_SRA \
Apocalathium_aciculiferum_MMETSP2 \
Azadinium_spinosum_MMETSP3 \
Brandtodinium_nutricula0_SRA \
Chromera_velia_MMETSP \
Crypthecodinium_cohnii_MMETSP4 \
Cryptoperidiniopsis_sp0_GG \
Dinophysis_acuminata_MMETSP \
Dinophysis_fortii0_SRA \
Durinskia_baltica_MMETSP2 \
Gambierdiscus_australes_MMETSP \
Gonyaulax_spinifera_MMETSP \
Green_Dinoflagellate_M0_SRA \
Green_Dinoflagellate_T0_SRA \
Gymnodinium_catenatum_MMETSP \
Gymnoxanthella_radiolariae0_SRA \
Gyrodiniellum_shiwhaense0_SRA \
Heterocapsa_arctica_MMETSP \
Heterocapsa_rotundata_MMETSP \
Karenia_brevis_MMETSP2_U \
Karlodinium_veneficum_MMETSP3 \
Kryptoperidinium_foliaceum_MMETSP2_CCMP \
Lepidodinium_chlorophorum0_SRA \
Lingulodinium_polyedra_MMETSP4 \
Margalefidinium_polykrikoides0_SRA \
Noctiluca_scintillans_MMETSP \
Nusuttodinium_aeruginosum0_SRA \
Oxyrrhis_marina0_MM \
Paragymnodinium_shiwhaense0_SRA \
Pelagodinium_beii0_SRA \
Peridinium_bipes0_SRA \
Pfiesteria_piscicida0_SRA \
Polykrikos_lebouriae0_GG \
Proterythropsis_metatranscriptome0_GG \
Prorocentrum_minimum_MMETSP3 \
Pyrocystis_lunula2_SRA \
Ross_Sea_Dinoflagellate0_SRA \
Scrippsiella_hangoei_MMETSP5 \
Scrippsiella_trochoidea_MMETSP3 \
Togula_jolla_MMETSP \
Yihiella_yeosuensis0_SRA \
)

for library in "${libs[@]}";
do
	shortname=${library:5:12}
	echo "submitting ${library}"
	echo "as ${shortname}"
	sbatch --export=library="${library}" --job-name="${shortname}" --time=24:00:00 --account=jwisecav --ntasks=1 --mail-user=zoark0@gmail.com --output="${shortname}"_status.out --error="${shortname}"_status.err --mem=90000 ./count_splicing.sbatch

done
echo "done"