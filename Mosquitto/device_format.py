# INFRARED SENSOR
{
    "id":"16",
    "name":"INFRARED",
    # X=OUT1OUt2 // 00,01,10,11 -> 0: no obstacles
    "data":"X",
    "unit":""
}

# LIGHT SENSOR
{
    "id":"13",
    "name":"Light",
    # type X int from 0 to 1023
    # X < 100 : dark 
    # # X > 100: bright
    "data":"X",  
    "'unit":"%"
}

#SOIL MOSTURE SENSOR
{
    "id":"9",
    "name":"SOIL",
    # type X int from 0 to 1023
    # X < 100 : dry 
    # # X > 100: wet
    "data":"X",  
    "'unit":"%"
}

# Reply Pump 
# Actually pump is just attached to Replay so we control the Replay circuit (to turn ON|OFF)
{
"id":"11",
"name":"RELAY",
"data":"X",
"unit":""
}
#TEMPERATURE SENSOR
{
    "id":"7",
    "name": "TEMP-HUMID",
    "data":"X",  # type X int
    "'unit":"C-%"
}