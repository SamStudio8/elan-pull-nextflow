#!/usr/bin/env nextflow

params.version = "v1"
params.qc = "/cephfs/covid/bham/nicholsz/artifacts/${params.version}/qc/test.qc"
params.artifacts_root = "/cephfs/covid/bham/nicholsz/artifacts/${params.version}/"

Channel
    .fromPath(params.qc)
    .splitCsv(sep:'\t', header: true)
    .filter { row -> Float.parseFloat(row.pc_acgt) > 50.00 }
    .filter { row -> Float.parseFloat(row.pc_pos_cov_gte10) > 50 }
    .map { row-> tuple(file([params.artifacts_root, row.fasta_path].join('/')), file([params.artifacts_root, row.bam_path].join('/'))) }
    .set { manifest_ch }

process copy_artifacts {
    tag { fasta }

    input:
    tuple file(fasta), file(bam) from manifest_ch

    output:
    publishDir path: "${params.location}/${params.version}/fasta/", pattern: "${fasta}", mode: "copy"
    publishDir path: "${params.location}/${params.version}/alignment/", pattern: "${bam}", mode: "copy"
    tuple file(fasta), file(bam) into artifact_ch

    """
    touch ${fasta}
    touch ${bam}
    """
}
