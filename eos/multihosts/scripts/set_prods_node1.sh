#!/bin/bash

echo "Set prods (node1)"
cleos push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"node1\",\"block_signing_key\": \"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\"}]}" -p eosio@active
