#!/bin/bash

echo "Set prods (eosio)"
cleos push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"eosio\",\"block_signing_key\": \"EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV\"}]}" -p eosio@active
