# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# Function to convert decimal to little-endian hex
dec_to_le_hex() {
  printf "%04x" "$1" | sed 's/../& /g' | awk '{for(i=NF;i>0;i--) printf $i}' | tr -d '\n'
}

publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
hashedPubKey=$(echo "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -binary | xxd -p -c 256)

timestamp=150
le_timestamp=$(dec_to_le_hex "$timestamp")

#<blocks> OP_CHECKSEQUENCEVERIFY OP_DROP OP_DUP OP_HASH160 <pubKeyHash> OP_EQUALVERIFY OP_CHECKSIG
script=$(echo "02${le_timestamp}b27576a914${hashedPubKey}88ac")
echo $script
