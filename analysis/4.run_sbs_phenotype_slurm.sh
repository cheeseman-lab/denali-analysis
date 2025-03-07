#!/bin/bash

# Start timing
start_time=$(date +%s)

# TODO: Set number of plates to process
NUM_PLATES=None

echo "===== STARTING SEQUENTIAL PROCESSING OF $NUM_PLATES PLATES ====="

# Process each plate in sequence
for PLATE in $(seq 1 $NUM_PLATES); do
    echo ""
    echo "==================== PROCESSING PLATE $PLATE ===================="
    echo "Started at: $(date)"
    
    # Start timing for this plate
    plate_start_time=$(date +%s)
    
    # Run Snakemake with plate filter for this plate
    snakemake --executor slurm --use-conda \
        --workflow-profile "slurm/" \
        --snakefile "/lab/barcheese01/mdiberna/brieflow/workflow/Snakefile_well_plate_level" \
        --configfile "config/config.yml" \
        --latency-wait 60 \
        --rerun-triggers mtime \
        --until all_sbs all_phenotype \
        --config plate_filter=$PLATE
    
    # Check if Snakemake was successful
    if [ $? -ne 0 ]; then
        echo "ERROR: Processing of plate $PLATE failed. Stopping sequential run."
    fi
    
    # End timing and calculate duration for this plate
    plate_end_time=$(date +%s)
    plate_duration=$((plate_end_time - plate_start_time))
    
    echo "==================== PLATE $PLATE COMPLETED ===================="
    echo "Finished at: $(date)"
    echo "Runtime for plate $PLATE: $((plate_duration / 3600))h $(((plate_duration % 3600) / 60))m $((plate_duration % 60))s"
    echo ""
    
    # Optional: Add a short pause between plates
    sleep 10
done

echo "===== ALL $NUM_PLATES PLATES PROCESSED SUCCESSFULLY ====="
