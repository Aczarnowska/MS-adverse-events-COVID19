import excel "../covid-sm-vacc/dane-szczepienia.xlsx", sheet("Sheet1") firstrow
drop if Dataszczepieniapierwsza=="" & Ośrodek=="SU Kraków"

gen gender=.
replace gender=1 if Płećpacjenta1K=="1"
replace gender=1 if Płećpacjenta1K=="K"
replace gender=0 if Płećpacjenta1K=="2"
replace gender=0 if Płećpacjenta1K=="M"
replace gender=1 if gender==.

gen postac=.
replace postac=1 if PostaćSM1CIS=="1"
replace postac=1 if PostaćSM1CIS=="1."
replace postac=1 if PostaćSM1CIS=="CIS"
replace postac=2 if PostaćSM1CIS=="2"
replace postac=2 if PostaćSM1CIS=="2."
replace postac=2 if PostaćSM1CIS=="RRMS"
replace postac=3 if PostaćSM1CIS=="3"
replace postac=3 if PostaćSM1CIS=="3."
replace postac=3 if PostaćSM1CIS=="PPMS"
replace postac=4 if PostaćSM1CIS=="4"
replace postac=4 if PostaćSM1CIS=="4."
replace postac=4 if PostaćSM1CIS=="SPMS"
replace postac=2 if postac==.

replace Chorobywspółistniejące1HA="11" if Chorobywspółistniejące1HA==""
gen HA=0
replace HA=1 if strpos(Chorobywspółistniejące1HA, "1") & strlen(Chorobywspółistniejące1HA)==1
replace HA=1 if strpos(Chorobywspółistniejące1HA, "1.")
replace HA=1 if strpos(Chorobywspółistniejące1HA, "1,")
gen DM=0
replace DM=1 if strpos(Chorobywspółistniejące1HA, "2")
//replace DM=1 if strpos(Chorobywspółistniejące1HA, "2.")
gen wiencowa=0
replace wiencowa=1 if strpos(Chorobywspółistniejące1HA, "3")
//replace wiencowa=1 if strpos(Chorobywspółistniejące1HA, "3.")
gen astma=0
replace astma=1 if strpos(Chorobywspółistniejące1HA, "4")
gen pochp=0
replace pochp=1 if strpos(Chorobywspółistniejące1HA, "5")
gen watroba=0
replace watroba=1 if strpos(Chorobywspółistniejące1HA, "6")
gen nerki=0
replace nerki=1 if strpos(Chorobywspółistniejące1HA, "7")
gen niedoboryimmuno=0
replace niedoboryimmuno=1 if strpos(Chorobywspółistniejące1HA, "8")
gen nowotwory=0
replace nowotwory=1 if strpos(Chorobywspółistniejące1HA, "9")
gen wspolinne=0
replace wspolinne=1 if strpos(Chorobywspółistniejące1HA, "10")
replace wspolinne=1 if strpos(Chorobywspółistniejące1HA, "przebyta")
replace wspolinne=1 if strpos(Chorobywspółistniejące1HA, "odbytu")
gen wspolbrak=0
replace wspolbrak=1 if strpos(Chorobywspółistniejące1HA, "11")
replace wspolbrak=1 if Chorobywspółistniejące1HA==" "

destring IlelatchorujenaSM, gen(lataSM)
replace lataSM=7 if lataSM==.
destring AktualnyEDSS, gen(EDSS)
replace EDSS=2 if EDSS==.

replace Rzutdo3chmiesięcyprzedszcz=2 if Rzutdo3chmiesięcyprzedszcz ==. 
replace Rzutdo3chmiesięcyprzedszcz=1 if Rzutdo3chmiesięcyprzedszcz ==3 

replace Ilelatprzedszczepieniemstoso=7 if Ilelatprzedszczepieniemstoso==.
replace Ilelatprzedszczepieniemstoso=lataSM if Ilelatprzedszczepieniemstoso>lataSM 

//brak obserwacji w ogóle
drop Liczbapłytekkrwiprzyprzyjęc Fibrynogenprzyprzyjęciu PoziomDdimerówprzyprzyjęciu Lokalizacjazakrzepicyzatokżyl Płynmrliczbakomórekml PłynmrpoziombiałkagL 

//obserwacje missing/0 albo missing/2
drop Płynmr1Tak 
drop Czynnikiryzykazakrzepicy Czypacjentbyłhospitalizowany 

replace Ośrodek=strrtrim(Ośrodek)
replace Dataszczepieniapierwsza = "0"+Dataszczepieniapierwsza if substr(Dataszczepieniapierwsza,2,1)=="."
//replace Dataszczepieniapierwsza = "0"+Dataszczepieniapierwsza if substr(Dataszczepieniapierwsza,2,1)=="/"
replace Dataszczepieniad = "0"+Dataszczepieniad if substr(Dataszczepieniad,2,1)=="."


gen pierwszamiesiac=""
replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="AP-Szczecin"
replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="Białystok"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,1)=="."
replace pierwszamiesiac=substr(Dataszczepieniapierwsza,5,2) if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,4,1)=="."
replace pierwszamiesiac="01" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="09" if Ośrodek=="Katowice" & substr(Dataszczepieniapierwsza,3,3)=="sep"
replace pierwszamiesiac="04" if Ośrodek=="Katowice" & Dataszczepieniapierwsza=="‘08.04.2021"

replace pierwszamiesiac="03" if Ośrodek=="Końskie" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Końskie" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Końskie" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Końskie" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Końskie" & substr(Dataszczepieniapierwsza,3,3)=="jul"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,1)=="."
replace pierwszamiesiac=substr(Dataszczepieniapierwsza,5,2) if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,4,1)=="."
replace pierwszamiesiac="01" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="07" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="11" if Ośrodek=="Ligota-Katowice" & substr(Dataszczepieniapierwsza,3,3)=="nov"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,1)=="."
replace pierwszamiesiac="01" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="09" if Ośrodek=="Lublin" & substr(Dataszczepieniapierwsza,3,3)=="sep"

replace pierwszamiesiac="05" if Ośrodek=="MSSW" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="MSSW" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="MSSW" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="MSSW" & substr(Dataszczepieniapierwsza,3,3)=="aug"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,1)=="."
replace pierwszamiesiac=substr(Dataszczepieniapierwsza,5,2) if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,4,1)=="."
replace pierwszamiesiac="01" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="09" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="sep"
replace pierwszamiesiac="10" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="oct"
replace pierwszamiesiac="11" if Ośrodek=="Poznań" & substr(Dataszczepieniapierwsza,3,3)=="nov"
replace pierwszamiesiac="06" if Ośrodek=="Poznań" & Dataszczepieniapierwsza=="‘09.06.2021"
replace pierwszamiesiac="00" if Ośrodek=="Poznań" & pierwszamiesiac=="12"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,1,2) if Ośrodek=="Resmedica-Kielce" & substr(Dataszczepieniapierwsza,3,1)=="."

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,1)=="."
replace pierwszamiesiac="01" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="09" if Ośrodek=="Rzeszów" & substr(Dataszczepieniapierwsza,3,3)=="sep"
replace pierwszamiesiac="00" if Ośrodek=="Rzeszów" & Dataszczepieniapierwsza=="29dec2020"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,1)=="."
replace pierwszamiesiac="01" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="09" if Ośrodek=="SU Kraków" & substr(Dataszczepieniapierwsza,3,3)=="sep"
replace pierwszamiesiac="00" if Ośrodek=="SU Kraków" & Dataszczepieniapierwsza=="30dec2020"

replace pierwszamiesiac="02" if Ośrodek=="USK Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="USK Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="USK Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="USK Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="USK Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="USK Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="jul"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2)  if Ośrodek=="WAM"

replace pierwszamiesiac="02" if Ośrodek=="WSS Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="WSS Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="WSS Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="WSS Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="WSS Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="WSS Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="WSS Olsztyn" & substr(Dataszczepieniapierwsza,3,3)=="aug"

replace pierwszamiesiac="01" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="WUM" & substr(Dataszczepieniapierwsza,3,3)=="aug"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,1)=="."
replace pierwszamiesiac="01" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="10" if Ośrodek=="Wrocław" & substr(Dataszczepieniapierwsza,3,3)=="oct"
replace pierwszamiesiac="00" if Ośrodek=="Wrocław" & Dataszczepieniapierwsza=="28dec2020"

replace pierwszamiesiac=substr(Dataszczepieniapierwsza,4,2) if Ośrodek=="ZABRZE"

replace pierwszamiesiac="01" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="09" if Ośrodek=="Łódź" & substr(Dataszczepieniapierwsza,3,3)=="sep"

replace pierwszamiesiac="01" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="jan"
replace pierwszamiesiac="02" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="feb"
replace pierwszamiesiac="03" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="mar"
replace pierwszamiesiac="04" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="apr"
replace pierwszamiesiac="05" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="may"
replace pierwszamiesiac="06" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="jun"
replace pierwszamiesiac="07" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="jul"
replace pierwszamiesiac="08" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="aug"
replace pierwszamiesiac="09" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="sep"
replace pierwszamiesiac="10" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="oct"
replace pierwszamiesiac="11" if Ośrodek=="Bytom" & substr(Dataszczepieniapierwsza,3,3)=="nov"

replace pierwszamiesiac="06" if pierwsza=="6."

tab Ośrodek pierwszamiesiac, miss

gen drugamiesiac=""
replace drugamiesiac=substr(Dataszczepieniad,4,2) if substr(Dataszczepieniad,3,1)=="."
replace drugamiesiac=substr(Dataszczepieniad,5,2) if substr(Dataszczepieniad,4,1)=="."
replace drugamiesiac=substr(Dataszczepieniad,1,2) if substr(Dataszczepieniad,3,1)=="." & Ośrodek=="Resmedica-Kielce"
replace drugamiesiac="01" if substr(Dataszczepieniad,3,3)=="jan"
replace drugamiesiac="02" if substr(Dataszczepieniad,3,3)=="feb"
replace drugamiesiac="03" if substr(Dataszczepieniad,3,3)=="mar"
replace drugamiesiac="04" if substr(Dataszczepieniad,3,3)=="apr"
replace drugamiesiac="05" if substr(Dataszczepieniad,3,3)=="may"
replace drugamiesiac="06" if substr(Dataszczepieniad,3,3)=="jun"
replace drugamiesiac="07" if substr(Dataszczepieniad,3,3)=="jul"
replace drugamiesiac="08" if substr(Dataszczepieniad,3,3)=="aug"
replace drugamiesiac="09" if substr(Dataszczepieniad,3,3)=="sep"
replace drugamiesiac="10" if substr(Dataszczepieniad,3,3)=="oct"
replace drugamiesiac="11" if substr(Dataszczepieniad,3,3)=="nov"
replace drugamiesiac="12" if substr(Dataszczepieniad,3,3)=="dec"
replace drugamiesiac="05" if Dataszczepieniad=="‘01.05.2021"

replace Powikłaniapo1szejdawcesz=2 if Powikłaniapo1szejdawcesz==.

gen powbol=0
replace powbol=1 if strpos(Po1szejdawce1Bólwmiejsc, "1") & strlen(Po1szejdawce1Bólwmiejsc)==1
replace powbol=1 if strpos(Po1szejdawce1Bólwmiejsc, "1.")
replace powbol=1 if strpos(Po1szejdawce1Bólwmiejsc, "1,")
////ROZRÓŻNIĆ OD 12!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
gen powskora=0
replace powskora=1 if strpos(Po1szejdawce1Bólwmiejsc, "2")
//replace DM=1 if strpos(Chorobywspółistniejące1HA, "2.")
gen powgoraczka=0
replace powgoraczka=1 if strpos(Po1szejdawce1Bólwmiejsc, "3")
gen powzmeczenie=0
replace powzmeczenie=1 if strpos(Po1szejdawce1Bólwmiejsc, "4")
gen powglowa=0
replace powglowa=1 if strpos(Po1szejdawce1Bólwmiejsc, "5")
gen powmiesnie=0
replace powmiesnie=1 if strpos(Po1szejdawce1Bólwmiejsc, "6")
gen powbiegunka=0
replace powbiegunka=1 if strpos(Po1szejdawce1Bólwmiejsc, "7")
gen powbudnosci=0
replace powbudnosci=1 if strpos(Po1szejdawce1Bólwmiejsc, "8")
gen powbrzuch=0
replace powbrzuch=1 if strpos(Po1szejdawce1Bólwmiejsc, "9")
gen powzlesamo=0
replace powzlesamo=1 if strpos(Po1szejdawce1Bólwmiejsc, "10")
gen powanafil=0
replace powanafil=1 if strpos(Po1szejdawce1Bólwmiejsc, "11")
gen powinne=0
replace powinne=1 if strpos(Po1szejdawce1Bólwmiejsc, "12")
//spr czy liczebności się zgadzają!!!!


///spr kropki!!
////tab Nasilenieobjawów1Łagodne

replace Ustąpienieobjawów=5 if Ustąpienieobjawów==7

gen pow2bol=0
replace pow2bol=1 if strpos(Po2giejdawce1B, "1") & strlen(Po2giejdawce1B)==1
replace pow2bol=1 if strpos(Po2giejdawce1B, "1.")
replace pow2bol=1 if strpos(Po2giejdawce1B, "1,")
gen pow2skora=0
replace pow2skora=1 if strpos(Po2giejdawce1B, "2")
//replace DM=1 if strpos(Chorobywspółistniejące1HA, "2.")
gen pow2goraczka=0
replace pow2goraczka=1 if strpos(Po2giejdawce1B, "3")
gen pow2zmeczenie=0
replace pow2zmeczenie=1 if strpos(Po2giejdawce1B, "4")
gen pow2glowa=0
replace pow2glowa=1 if strpos(Po2giejdawce1B, "5")
gen pow2miesnie=0
replace pow2miesnie=1 if strpos(Po2giejdawce1B, "6")
gen pow2biegunka=0
replace pow2biegunka=1 if strpos(Po2giejdawce1B, "7")
gen pow2budnosci=0
replace pow2budnosci=1 if strpos(Po2giejdawce1B, "8")
gen pow2brzuch=0
replace pow2brzuch=1 if strpos(Po2giejdawce1B, "9")
gen pow2zlesamo=0
replace pow2zlesamo=1 if strpos(Po2giejdawce1B, "10")
gen pow2anafil=0
replace pow2anafil=1 if strpos(Po2giejdawce1B, "11")
gen pow2inne=0
replace pow2inne=1 if strpos(Po2giejdawce1B, "12")

replace Nasilenieobjawów1Łagodne="4" if Nasilenieobjawów1Łagodne==""
replace Nasilenieobjawów1Łagodne="4" if Nasilenieobjawów1Łagodne=="4."
encode Nasilenieobjawów1Łagodne, gen(nasilenie1)

clonevar nasilenie2=Nasilenieobjawów1Łag
replace nasilenie2=4 if nasilenie2==0

replace Ciężkiepowikłaniaposzczepienne=0 if Ciężkiepowikłaniaposzczepienne==2

drop if Terapia1Interfero==.
drop if pierwszamiesiac==""

gen i=1
replace Rodzajszczepionki1Pfizer=1 if Rodzajszczepionki1Pfizer==.

drop if Rodzajszczepionki1Pfizer ==5

global powiklanie1="powbol powskora powgoraczka powzmeczenie powglowa powmiesnie powbiegunka powbudnosci powbrzuch powzlesamo powanafil powinne"
gen sumapow1=0
foreach i of global powiklanie1 {
replace sumapow1=sumapow1+1 if `i'==1
}
global powiklanie2="pow2bol pow2skora pow2goraczka pow2zmeczenie pow2glowa pow2miesnie pow2biegunka pow2budnosci pow2brzuch pow2zlesamo pow2anafil pow2inne"
gen sumapow2=0
foreach i of global powiklanie2 {
replace sumapow2=sumapow2+1 if `i'==1
}
gen sumasuma12=sumapow1+sumapow2

gen mrna=0
replace mrna=1 if Rodzajszczepionki1Pfizer==1
replace mrna=1 if Rodzajszczepionki1Pfizer==3

clonevar moderna=Rodzajszczepionki1Pfizer
replace moderna=. if Rodzajszczepionki1Pfizer==2
replace moderna=. if Rodzajszczepionki1Pfizer==4
clonevar astra=Rodzajszczepionki1Pfizer
replace astra=. if Rodzajszczepionki1Pfizer==3
replace astra=. if Rodzajszczepionki1Pfizer==4
clonevar jj=Rodzajszczepionki1Pfizer
replace jj=. if Rodzajszczepionki1Pfizer==2
replace jj=. if Rodzajszczepionki1Pfizer==3

//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

gen powiklanie1=0
replace powiklanie1=1 if sumapow1>0
replace powiklanie1=1 if (Czasodprzyjęciaszczepienia!="" & Czasodprzyjęciaszczepienia !="4")
replace powiklanie1=1 if (Nasilenieobjawów1Łagodne!="" & Nasilenieobjawów1Łagodne!="4")
replace powiklanie1=1 if (Ustąpienieobjawów!=. & Ustąpienieobjawów!=0)

rename Nasilenieobjawów1Łag Nasilenieobjawów2
gen powiklanie2=0
replace powiklanie2=1 if sumapow2>0
replace powiklanie2=1 if (Czasodprzyjęciaszczepienia2!="" & Czasodprzyjęciaszczepienia2 !="4")
replace powiklanie2=1 if (Nasilenieobjawów2!=. & Nasilenieobjawów2!=4 & Nasilenieobjawów2!=0)
replace powiklanie2=1 if (Ustąpienieobjawów2!=. & Ustąpienieobjawów2!=0)

gen proba=0
replace proba=1 if sumapow1>0
replace proba=1 if sumapow2>0

//keep if proba==1
drop if Ośrodek=="Końskie"
drop if Ośrodek=="MSSW"
//drop if Ośrodek=="WAM"
drop if Ośrodek=="USK Olsztyn"
drop if Ośrodek=="WSS Olsztyn"



global wspol="HA DM wiencowa astma pochp watroba nerki niedoboryimmuno nowotwory wspolinne wspolbrak"
global vacc="mrna moderna astra jj"
///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///LISTA AGATY///
////////////////////////////////
tab Ośrodek
tab Ośrodek proba, row
/////////////////////
//// 1 ////
/////////////
tab gender
table gender, c(mean Wiekpacjenta sd Wiekpacjenta p50 Wiekpacjenta iqr Wiekpacjenta)
tab postac
table i, c(mean lataSM sd lataSM p50 lataSM iqr lataSM)
table i, c(mean EDSS sd EDSS p50 EDSS iqr EDSS)
sum Wiekpacjenta lataSM EDSS, detail
bysort gender: sum Wiekpacjenta
tab Terapia1Interfero
tab Rodzajszczepionki1Pfizer
sum Ilelatprzedszczepieniemstoso
sum Ilelatprzedszczepieniemstoso, detail

tab gender proba, row
bysort proba: table gender, c(mean Wiekpacjenta sd Wiekpacjenta p50 Wiekpacjenta iqr Wiekpacjenta)
tab postac proba, row
bysort proba: table i, c(mean lataSM sd lataSM p50 lataSM iqr lataSM)
bysort proba: table i, c(mean EDSS sd EDSS p50 EDSS iqr EDSS)
bysort proba: sum lataSM EDSS, detail
tab Terapia1Interfero proba, row
tab Rodzajszczepionki1Pfizer proba, row

////////
///2
//////
tab Rzutdo3chmiesięcyprzedszcz

tab Rzutpo1szejdawce
tab Rzutpo2giejdawce

tab Rzutdo3chmiesięcyprzedszcz proba, row

tab Rzutpo1szejdawce proba, row
tab Rzutpo2giejdawce proba, row
///////
///3
////////
tab pierwszamiesiac 
tab drugamiesiac

table pierwszamiesiac, c(mean sumapow1 mean sumapow2 mean sumasuma12)
table drugamiesiac, c(mean sumapow1 mean sumapow2 mean sumasuma12)

global powiklanie1="powbol powskora powgoraczka powzmeczenie powglowa powmiesnie powbiegunka powbudnosci powbrzuch powzlesamo powanafil powinne"
foreach i of global powiklanie1 {
di "`i'"
tab `i'
}

global powiklanie2="pow2bol pow2skora pow2goraczka pow2zmeczenie pow2glowa pow2miesnie pow2biegunka pow2budnosci pow2brzuch pow2zlesamo pow2anafil pow2inne"
foreach i of global powiklanie2 {
tab `i'
}

tab sumapow1
tab sumapow2

////////////////////
///5
//////////////
tab PogorszeniewSM1

tab Czasodprzyjęciaszczepienia1 
tab Czastrwaniapogorszenia 
tab AO 
tab AP

tab Czasodprzyjęciaszczepienia1 if PogorszeniewSM1=="1"
tab Czastrwaniapogorszenia if PogorszeniewSM1=="1"
tab AO if PogorszeniewSM1=="1" 
tab AP if PogorszeniewSM1=="1"

tab Czasodprzyjęciaszczepienia1 AO
////////////////////////////
//////6
//////////////////////

tab InfekcjaSARSCoV2po1
tab InfekcjaSARSCoV2poszczepieni

/////
///czy po którejś szczepione częściej objawy nieporządane
foreach i of global powiklanie1{
tab Rodzajszczepionki1Pfizer `i', chi exact row
}
foreach i of global powiklanie2{
tab Rodzajszczepionki1Pfizer `i', chi exact row
}

foreach k of global vacc{
foreach i of global powiklanie1{
di "`k' `i'"
tabodds `i' `k', or
}
}

foreach k of global vacc{
foreach i of global powiklanie2{
di "`k' `i'"
tabodds `i' `k', or
}
}


/////
///czy wiek albo płeć częściej korelowały z działaniami niepożądanymi?
foreach i of global powiklanie1{
di "`i'"
tabodds  `i' gender, or
}
foreach i of global powiklanie2{
di "`i'"
tabodds  `i' gender, or
}
foreach i of global powiklanie1{
di "`i'"
ttest Wiekpacjenta, by(`i') 
}
foreach i of global powiklanie2{
di "`i'"
ttest Wiekpacjenta, by(`i') 
}

/////
///EDSSa działania niepożądane
foreach i of global powiklanie1{
ranksum EDSS, by(`i')
}
foreach i of global powiklanie2{
ranksum EDSS, by(`i')
}

tab2 EDSS proba, gamma taub V
median EDSS, by(proba)
graph box EDSS, over(proba)
ttest EDSS, by(proba)

ellip EDSS Wiek, by(proba) plot(scatter EDSS Wiekpacjenta)

twoway (histogram EDSS if proba==1, color(green))(histogram EDSS if proba==0), legend(order(1 "powiklania" 2 "brak"))
twoway (kdensity EDSS if proba==1, lcolor(navy))(kdensity EDSS if proba==0, lcolor(orange)), legend(order(1 "Presence of adverse events" 2 "Absence of adverse events")) graphregion(fcolor(white)) xtitle("") ytitle("EDSS kernel density")
/////
//jakie leki
foreach i of global powiklanie1{
tab Terapia1Interfero `i', chi exact row
}
foreach i of global powiklanie2{
tab Terapia1Interfero `i', chi exact row
}

///////
///choroby współistniejące
foreach j of global powiklanie1{
foreach i of global wspol{
di "`j' `i'"
tabodds `j' `i', or
}
}
foreach j of global powiklanie2{
foreach i of global wspol{
di "`j' `i'"
tabodds `j' `i', or
}
}

///////
//mRNA czy wektor
tab mrna powbol, chi exact row

foreach i of global powiklanie1{
tabodds `i' mrna
}
foreach i of global powiklanie2{
di "`i'"
tabodds `i' mrna
}

//////
///czy uboczne się korelują
tetrachoric powbol powskora powgoraczka powzmeczenie powglowa powmiesnie powbiegunka powbudnosci powbrzuch powzlesamo powanafil powinne, pw stats(rho p)
tetrachoric pow2bol pow2skora pow2goraczka pow2zmeczenie pow2glowa pow2miesnie pow2biegunka pow2budnosci pow2brzuch pow2zlesamo pow2anafil pow2inne, stats(rho p)

foreach i of global powiklanie1{
tetrachoric `i' pow2bol pow2skora pow2goraczka pow2zmeczenie pow2glowa pow2miesnie pow2biegunka pow2budnosci pow2brzuch pow2zlesamo pow2anafil pow2inne, stats(rho p)
}
///////
//// wszystkie czynniki w jednym modelu
foreach i of global powiklanie1{
capture eststo: logit `i' Wiekpacjenta gender EDSS i.Rodzajszczepionki1Pfizer i. Terapia1Interfero, or
}
esttab, eform pr2 p aic
eststo clear
foreach i of global powiklanie1{
capture eststo: logit `i' Wiekpacjenta gender EDSS i.Rodzajszczepionki1Pfizer, or
}
esttab, eform pr2 p aic
eststo clear
/*
foreach i of global powiklanie1{
capture eststo: logit `i' Wiekpacjenta gender EDSS mrna HA DM wiencowa astma pochp watroba nerki niedoboryimmuno nowotwory wspolinne wspolbrak, or
}
esttab, eform pr2 p aic
eststo clear
*/
foreach i of global powiklanie1{
capture eststo: logit `i' Wiekpacjenta gender EDSS mrna, or
}
esttab, eform pr2 p aic
eststo clear

foreach i of global powiklanie2{
capture eststo: logit `i' Wiekpacjenta gender EDSS i.Rodzajszczepionki1Pfizer i. Terapia1Interfero, or
}
esttab, eform pr2 p aic
eststo clear
foreach i of global powiklanie2{
capture eststo: logit `i' Wiekpacjenta gender EDSS i.Rodzajszczepionki1Pfizer, or
}
esttab, eform pr2 p aic
eststo clear
/*
foreach i of global powiklanie2{
capture eststo: logit `i' Wiekpacjenta gender EDSS mrna HA DM wiencowa astma pochp watroba nerki niedoboryimmuno nowotwory wspolinne wspolbrak, or
}
esttab, eform pr2 p aic
eststo clear
*/
foreach i of global powiklanie2{
capture eststo: logit `i' Wiekpacjenta gender EDSS mrna, or
}
esttab, eform pr2 p aic
eststo clear


