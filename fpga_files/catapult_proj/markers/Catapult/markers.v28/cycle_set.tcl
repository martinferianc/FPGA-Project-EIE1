
# Loop constraints
directive set /markers/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /markers/core/main/asn#60 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#61 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#62 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#63 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#64 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#65 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#66 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#67 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/asn#68 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/io_write(volume:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/io_write(vout:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /markers/core/main/if:acc CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/if:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/aif#1:aif:acc CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/if:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/aif#5:aif:acc CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/and CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/and#1 CSTEPS_FROM {{.. == 1}}
directive set /markers/core/main/and#2 CSTEPS_FROM {{.. == 1}}
