=======================
Korzystanie ze skryptów:

1. Rozpakować angielskie properties np do podkatalogu EN1 i PL1 (te
   same angielskie stringi do obu)

2. Uruchomić generację plików .po: ./generatePO.sh EN1 "" po1

3. Zrobić merge z kompendium do plików .po: ./mergecompendium.sh (w
   skrypcie trzeba dopasować ścieżkę do katalogu z plikami .po - tutaj w
   przykładzie po1)

4. Uruchomić generację plików .properties z .po: ./generatePROP.sh PL1 po1

5. w katalogu PL1 powinny być .properties z polskimi wartościami

Podczas generacji .po mogą wystąpić błędy gettextu dotyczące różnych
znaków poza unicodem - trzeba je po prostu w plikach .properties czy
.po poprawić i uruchomić skrypt ponownie. (nie ma to wpływu na
późniejszą generację, bo potem kluczem nie jest angielski tekst, a
nazwa property).

Do działania tych merge'ów gettextu wymagany jest pakiet gettext devel
(program msgmerge).

=======================
Aktualizacja tłumaczenia w przypadku nowych tekstów w angielskim oryginale

Jesli do plikow properties doszly nowe tlumaczenia, to nalezy:

1. wygenerowac pliki .po z nowych .properties

2. wypelnic .po z istniejacego kompendium

3. wygenerowac kompendium z plikow .po (bedzie zawierac dotychczasowe tlumaczenia + nowe 
   nieprzetlumaczone. Polecenie: msgcat -o newcompendium.po <katalog_z_plikami_po>/*

4. dotlumaczyc brakujace fragmenty w nowym kompendium 

5. wypełnić ponownie pliki.po (mergecompendium.sh)

6. wygenerować polskie .properties

7. ...