flights = load 'wholeEnchilada.csv' using PigStorage(',');
flight_details = FOREACH flights GENERATE $16 as origin, (int)$19 AS taxi_in, (int)$20 AS taxi_out;
taxi_time = FOREACH flight_details GENERATE *, taxi_in + taxi_out AS merged;
grp_origin = GROUP taxi_time by origin;
ave_taxi_time = FOREACH grp_origin GENERATE group, AVG(taxi_time.merged);
store ave_taxi_time into 'aveTaxiByOriginPigResults';
