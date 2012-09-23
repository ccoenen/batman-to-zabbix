# encoding: utf-8
# batman to zabbix sender converter
require 'csv'

DEBUG = false
INFILENAME = ARGV[0] || 'batman.csv' # defaults to local file
OUTFILENAME = File.join(File.dirname(__FILE__), 'zabbix_values.txt')

BATMAN_COLUMNS = [
  :timestamp,              # "Datum Zeit",
  :level,                  # "Level % (0 -100 max)",
  :voltage,                # "Spannung (angepasst)",
  :temperature,            #"Temperatur °C",
  :display_brightness,     # "Display Helligkeit % (0-100)",
  :bluetoots_state,        # "Bluetooth off/on (0/100)",
  :signal_strength,        # "Signalstärke (asu 0 -31 max)",
  :charge_state,           # "Laden (0=No charge/discharge;80=Full;100=charging)",
  :network_state,          # "Netzwerktyp(0=keines;5=unbekannt;50=Wifi;60=GPRS;70=Edge;80=UMTS;85=CDMA;90=EVDO/E;91=1xRTT;92=HSDPA;94=HSUPA;96=HSPA;97=IDEN)",
  :charge_state_string,    # "Laden verbal",
  :todo_betriebsart,       # "Betriebsart",
  :network_state_string,   # "NetzwerkTyp verbal",
  :bluetooth_state_string, # "Bluetooth enabled/disabled",
  :accu_technology,        # "Akku Technologie",
  :voltage_real,           # "Real Spannung",
  :battery_state,          # "Batterie Status (1=Unbekannt; 2=Gut; 3=Ueberhitzt; 4=Defekt; 5=Ueberspannung; 6=Unbekannter Fehler;)",
  :connectivity,           # "Mobile Verbindungs Status (0=Nicht verbunden;1=Verbindungsaufbau;2=Verbunden IPT;3=Verbunden no IPT)",
  :mobile_service_sate,    # "Mobile Service Status (0=Normalbetrieb home or Roaming;1=Kein Betrieb;2=Nur Notruf;3=Abgeschaltet)",
  :logged_by               # "Logauslöser (1=GSM Signalstärke;2=ScreenOn;3=ScreenOff;4=AirplaneMode on/off;5=BatteryChange;6=DataconnectionChange;7=ServiceStateChange;8=CellLocationChange;9=Wifi APStatus Change;10=Wifi ConState change)" 
]

# CSV's default doesn't like batman's date-format
CSV::DateTimeMatcher = /\A\d\d\.\d\d\.\d{4}\s\d\d:\d\d:\d\d\Z/

count = 0 # used in debugging, only
File.open(OUTFILENAME, "w") do |outfile|
  outfile = STDOUT if DEBUG # output to stdout instead of file
  CSV.foreach(INFILENAME, headers: BATMAN_COLUMNS, converters: [:all]) do |row|
    next unless row[0].class == DateTime
    row.each do |key, value|
      outfile.puts "- #{key} #{row[0].strftime("%s")} #{value}"
    end
    break if DEBUG && 3 < count += 1 # only output the first few lines for debugging
  end
end
