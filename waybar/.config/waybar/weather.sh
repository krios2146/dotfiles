#!/usr/bin/zsh

typeset -A weather_types
typeset -A weather_symbols_day
typeset -A weather_symbols_night

weather_types=(
    [113]=Sunny 
    [116]=PartlyCloudy
    [119]=Cloudy
    [122]=VeryCloudy
    [143]=Fog
    [176]=LightShowers
    [179]=LightSleetShowers
    [182]=LightSleet
    [185]=LightSleet
    [200]=ThunderyShowers
    [227]=LightSnow
    [230]=HeavySnow
    [248]=Fog
    [260]=Fog
    [263]=LightShowers
    [266]=LightRain
    [281]=LightSleet
    [284]=LightSleet
    [293]=LightRain
    [296]=LightRain
    [299]=HeavyShowers
    [302]=HeavyRain
    [305]=HeavyShowers
    [308]=HeavyRain
    [311]=LightSleet
    [314]=LightSleet
    [317]=LightSleet
    [320]=LightSnow
    [323]=LightSnowShowers
    [326]=LightSnowShowers
    [329]=HeavySnow
    [332]=HeavySnow
    [335]=HeavySnowShowers
    [338]=HeavySnow
    [350]=LightSleet
    [353]=LightShowers
    [356]=HeavyShowers
    [359]=HeavyRain
    [362]=LightSleetShowers
    [365]=LightSleetShowers
    [368]=LightSnowShowers
    [371]=HeavySnowShowers
    [374]=LightSleetShowers
    [377]=LightSleet
    [386]=ThunderyShowers
    [389]=ThunderyHeavyRain
    [392]=ThunderySnowShowers
    [395]=HeavySnowShowers
)

weather_symbols_day=(
    [Unknown]=
    [Cloudy]=
    [Fog]=
    [HeavyRain]=
    [HeavyShowers]=
    [HeavySnow]=
    [HeavySnowShowers]=
    [LightRain]=
    [LightShowers]=
    [LightSleet]=
    [LightSleetShowers]=
    [LightSnow]=
    [LightSnowShowers]=
    [PartlyCloudy]=
    [Sunny]=
    [ThunderyHeavyRain]=
    [ThunderyShowers]=
    [ThunderySnowShowers]=
    [VeryCloudy]=
)

weather_symbols_night=(
    [Unknown]=
    [Cloudy]=
    [Fog]=
    [HeavyRain]=
    [HeavyShowers]=
    [HeavySnow]=
    [HeavySnowShowers]=
    [LightRain]=
    [LightShowers]=
    [LightSleet]=
    [LightSleetShowers]=
    [LightSnow]=
    [LightSnowShowers]=
    [PartlyCloudy]=
    [Sunny]=
    [ThunderyHeavyRain]=
    [ThunderyShowers]=
    [ThunderySnowShowers]=
    [VeryCloudy]=
)

# just doesn't fucking work
# curl -s 'wttr.in/krasnoyarsk?format=1'

data="$(curl -s 'wttr.in/krasnoyarsk?format=j1')"
current_condition="$(echo $data | jq '.current_condition | .[]')"

astronomy="$(echo $data | jq '.weather.[0].astronomy.[0]')"
sunset="$(echo $astronomy | jq -r '.sunset' | xargs -I xdd date -d xdd +%s)"
sunrise="$(echo $astronomy | jq -r '.sunrise' | xargs -I xdd date -d xdd +%s)"
current_time="$(date +%s)"


weather_symbols_map="weather_symbols_night"
if [ "$current_time" -gt "$sunrise" ] && [ "$current_time" -lt "$sunset" ]; then
    weather_symbols_map="weather_symbols_day"
fi

temp="$(echo $current_condition | jq -r '.temp_C')C°"
weather_code=$(echo $current_condition | jq -r '.weatherCode')
weather_type=$weather_types[$weather_code]
weather_icon=${${(P)weather_symbols_map}[$weather_type]}

text="$weather_icon $temp"
tooltip="$(curl -s 'https://wttr.in/krasnoyarsk?M&T')"
tooltip="$(echo $tooltip | sed '1d' | head -n -3)"

jq -nc --arg text "$text" --arg tooltip "$tooltip" '{text:$text, tooltip:$tooltip}'
