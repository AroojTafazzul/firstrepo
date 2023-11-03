// Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
// All Rights Reserved. 

// ---------------------------------------------------------
// Error Messages, Formats and Related Functions in GERMAN
// ---------------------------------------------------------

// Language Code
var g_strLanguageCode = "de";


// Constants for Amount format
var g_strDecimalDelimiter = ",";
var g_strDigitGroupingDelimiter = ".";


// Constants for Date format
var g_strGlobalDateFormat = "dd/mm/yyyy";
var g_strGlobalDateTimeFormat = "dd/mm/yyyy hh:mi:ss";
var g_strGlobalDateDelimiter = "/";
var g_strGlobalDateStartWeek = 1; // First day of the week, 0 for sunday, 1 for monday, etc.
var g_arrShortDayLabel = new Array('M','D','M','D','F','S','S');


// Perform SWIFT character set checking in the transaction submissions
var g_blnSWIFTChecking = true;


// Months
g_arrMonthLabel = new Array(13);

g_arrMonthLabel[1] = "Januar";
g_arrMonthLabel[2] = "Februar";
g_arrMonthLabel[3] = "M�rz";
g_arrMonthLabel[4] = "April";
g_arrMonthLabel[5] = "Mai";
g_arrMonthLabel[6] = "Juni";
g_arrMonthLabel[7] = "Juli";
g_arrMonthLabel[8] = "August";
g_arrMonthLabel[9] = "September";
g_arrMonthLabel[10] = "Oktober";
g_arrMonthLabel[11] = "November";
g_arrMonthLabel[12] = "Dezember";

//
// Error Messages
//
g_arrErrorMessages = new Array();

g_arrErrorMessages[1] = "Die W�hrung %s ist nicht g�ltig.";

g_arrErrorMessages[2] = "Es gibt kein '%s' in %s %s.";
g_arrErrorMessages[3] = "%s ist nicht ein g�ltiger Monat.";
g_arrErrorMessages[4] = "%s ist nicht ein g�ltiges Jahr.";
g_arrErrorMessages[5] = "%s ist nicht ein g�ltiges Datum (tt/mm/jjjj).";

g_arrErrorMessages[6] = "Das Ausgabedatum (%s) muss gleich oder sp�ter \nals das Antragsdatum (%s) sein.";
g_arrErrorMessages[7] = "Das Ausgabedatum (%s) muss gleich oder fr�her \nals das Ablaufsdatum (%s) sein.";
g_arrErrorMessages[8] = "Das Verschiffungsdatum (%s)  muss gleich oder sp�ter \nals das Ausgabedatum (%s) sein.";
g_arrErrorMessages[9] = "Das Ablaufsdatum (%s) muss gleich oder sp�ter \nals das Antragsdatum (%s) sein.";
g_arrErrorMessages[10] = "Das Ablaufsdatum (%s) muss gleich oder sp�ter \nals das Verschiffungsdatum (%s) sein.";

g_arrErrorMessages[11] = "Dieses Feld muss eine g�ltige Nummer enthalten.";
g_arrErrorMessages[12] = "Die Toleranz und der h�chster Akkreditivbetrag ausschliessen sigh gegenseitig.";
g_arrErrorMessages[13] = "Alle Pflichtfelde mussen einen Wert enthalten um die Transaktion zu einreichen.";

g_arrErrorMessages[14] = "Die Anzahl der Zeilen des Felds �berschreitet das Limit (%s Zeilen).";
g_arrErrorMessages[15] = "Die Gr�sse des Felds �berschreitet das Limit (%s Zeilen x %s Zeichen).";

g_arrErrorMessages[16] = "Ein Stand-By Akkreditiv muss unwiderruflich sein um �bertragbar zu sein.";

g_arrErrorMessages[17] = "Das �nderungsdatum (%s) muss gleich oder sp�ter \nals das Ausgabedatum (%s) sein.";
g_arrErrorMessages[18] = "Der abgenommen Betrag kann nicht gr�sser als der aktueller Betrag sein.";
g_arrErrorMessages[19] = "Ein Feld muss wenigstens ge�ndert sein um die Akte g�ltig zu werden.";
g_arrErrorMessages[20] = "Leider gibt es nicht dieses Markmal in ihrem Browser. Sie k�nnen auf die Liste den empfohlen Browser hinweisen um dieses Problem l�sen.";

g_arrErrorMessages[21] = "Das Ausgabedatum (%s) muss gleich oder fr�her \nals das F�lligkeitsdatum (%s) sein.";
g_arrErrorMessages[22] = "Das F�lligkeitsdatum (%s) muss gleich oder sp�ter \nals das Antragsdatum (%s) sein.";

g_arrErrorMessages[23] = "Die Dokumentvorlage Id ist ein Pflichtfeld wenn Sie wollen die Dokumentvorlage abspeichern.";

g_arrErrorMessages[24] = "Der neue Betrag �berschreitet den befugten H�chstwert.";

g_arrErrorMessages[25] = "Das �nderungsdatum (%s) muss gleich oder fr�her \nals das neues Ablaufsdatum (%s) sein.";

g_arrErrorMessages[26] = "Das unzul�ssiges Zeichen '%s' ist gefunden in ihrer Akte. Ausbessern Sie bitte das (die) Feld(en). Die befugte Zeichenmenge beinhalten die folgende Zeichen:\na..zA..Z0..9 /-?:().,'+";

g_arrErrorMessages[27] = "Im Falle von einer Zunahme oder einer Abnahme des Transaktionsbetrags m�ssen Sie den Grund dieser �nderung in dem erz�hlenden Feld eintasten.";

// same message g_arrErrorMessages[8]
//g_arrErrorMessages[28] = "Das Verschiffungsdatum (%s) muss gleich oder sp�ter \nals das Antragsdatum (%s) sein.";

g_arrErrorMessages[29] = "Das Ausf�hrungdatum (%s) muss gleich oder sp�ter \nals das Antragsdatum (%s) sein.";

g_arrErrorMessages[30] = "Das Kennzeichen '%s' is nicht erlaubt f�r dieses Feld.";

g_arrErrorMessages[31] = "Alle Pflichtfelde mussen einen Wert enthalten.";

g_arrErrorMessages[32] = "Sie m�ssen die Einzelheiten best�tigen um die Transaktion zu einreichen.";

g_arrErrorMessages[33] = "Dieses Element steht schon in Ihre List."

g_arrErrorMessages[34] = "The password length is invalid (please key between %s and %s characters).";
// Alternative error message
g_arrErrorMessages[35] = "Das Kennwort ist nicht g�ltig (tasten Sie bitte zumindest %s Zeichen ein \n mit zumindest ein alphabetisches und ein numerisches Zeichen)."


g_arrErrorMessages[36] = "Sie m�ssen den W�hrungkurs zuerst eintasten.";
g_arrErrorMessages[37] = "Sie m�ssen ein Format w�hlen f�r alle vorgelegte Dokumente.";

g_arrErrorMessages[38] = "Sie m�ssen ein (und nur ein) URL ausw�hlen";

g_arrErrorMessages[39] = "Leider k�nnen Sie nur %s Datens�tze eintasten.";
g_arrErrorMessages[40] = "Der Parameter %s ist schon benutzt in einem Kriterium deren Spalte hat eine verschiedene Art. \nBitte w�hlen Sie einen anderen Parameter aus.";
//Telex
g_arrErrorMessages[41] = "Das unzul�ssiges Zeichen '%s' ist gefunden in ihrer Akte. Ausbessern Sie bitte das (die) Feld(en). Die befugte Zeichenmenge beinhalten die folgende Zeichen:\nA..Z0..9'()+,-./:=?";

g_arrErrorMessages[42] = "Sie benutzen relative Spaltenbreiten. \nDeshalb die Summe von allen Spaltenbreiten muss 100% sein.";

g_arrErrorMessages[43] = "Sie m�ssen wenigstens ein sp�testes Verschiffungsdatum \noder einen Plan der Verschiffung ausw�hlen.";

g_arrErrorMessages[45] = "Transfer amount can't be greater than Letter of Credit amount.";

g_arrErrorMessages[46] = "Die h�chste Anzahl den angezogen Datens�tzen \nmuss zwischen 1 und 100 sein.";

g_arrErrorMessages[47] = "Das Bericht is nicht Multi-Prod�kte. Sie k�nnen nicht eines andere Produkt anh�ngen.";
// To Do translate :g_arrErrorMessages[48] = "You must choose a frequence";
//g_arrErrorMessages[49] = "You must choose one day of the week";
//g_arrErrorMessages[50] = "You must you one day of the month.";
g_arrErrorMessages[51] = "Die Gr�sse des Felds �berschreitet das Limit (%s Zeichen. Sie haben geschrieben %s Zeichen.).";

// Confirmation Messages
//
g_arrConfirmationMessages = new Array();

g_arrConfirmationMessages[1] = "Sie sind im Begriff die aktuelle Akte zu abspeichern. Sind Sie sicher ?";
g_arrConfirmationMessages[2] = "Sie sind im Begriff die aktuelle Akte zu einreichen. Sind Sie sicher ?";
g_arrConfirmationMessages[3] = "Sie sind im Begriff die aktuelle Akte als eine Dokumentvorlage zu abspeichern. Sind Sie sicher ?";
g_arrConfirmationMessages[4] = "Sie sind im Begriff die aktuelle Seite zu verlassen. Sind Sie sicher ?";
g_arrConfirmationMessages[5] = "Sie sind im Begriff die Einzelheiten der Transaktion zu �ndern. Sind Sie sicher?";
g_arrConfirmationMessages[6] = "Sie sind im Begriff %s Rekorden zu erl�schen. Sind Sie sicher ?";
g_arrConfirmationMessages[7] = "Sie sind im Begriff den Rekord '%s' zu erl�schen. Sind Sie sicher ?";

g_arrConfirmationMessages[8] = "Ihre Wahrenbeschreibung �berschreitet das Limit in einer SWIFT Mitteilung (100 Zeilen). Wollen Sie lieber den Sende-Betrieb Telex sein ?";
g_arrConfirmationMessages[9] = "Ihre Liste den erforderlichen Dokumente �berschreitet das Limit in einer SWIFT Mitteilung (100 Zeilen). Wollen Sie lieber den Sende-Betrieb Telex sein ?";
g_arrConfirmationMessages[10] = "Ihre zus�tzliche Anweisungen �berschreiten das Limit in einer SWIFT Mitteilung (100 Zeilen). Wollen Sie lieber den Sende-Betrieb Telex sein ?";
g_arrConfirmationMessages[11] = "Sie sind im Begriff diesen Rekord zu erl�schen. Sind Sie sicher ?";
// Merge with the head
//g_arrConfirmationMessages[11] = "Sie sind im Begriff diesen Rekord zu erl�schen. Sind Sie sicher ?";

g_arrConfirmationMessages[12] = "Das Dokument, das Sie herunterladen wollen, ist %s gross. Sind Sie sicher ?";

g_arrConfirmationMessages[14] = "Sie sind im Begriff Versionen den ausgew�hlten Dokumente zu kreieren.\nSind Sie sicher ?";
g_arrConfirmationMessages[15] = "Sie sind im Begriff ein Dokument zu addieren.\nSind Sie sicher ?";
g_arrConfirmationMessages[16] = "Sie sind im Begriff ein Dokument zu erl�schen.\nSind Sie sicher ?";
g_arrConfirmationMessages[17] = "Ein Formular wird angezeigt um die Daten des Dokumente zu �ndern.\nSind Sie sicher ?";
g_arrConfirmationMessages[18] = "Ein Formular wird angezeigt um die Daten der Dokumentvorlage zu �ndern.\nSind Sie sicher ?";
g_arrConfirmationMessages[19] = "Wollen Sie die Dokumentvorlage zu schliessen ?";
g_arrConfirmationMessages[20] = "Sie sind im Begriff die Gesamtw�hrung zu �ndern.\nSie k�nnen Daten l�sen in Ihren Produktformularen oder in Ihren Geb�hrformularen.\nSind Sie sicher ?";
g_arrConfirmationMessages[21] = "Sie sind im Begriff die aktuelle Akte zu einreichen. Sind Sie sicher ?\n\nBemerkung: Das %s ist in Befolgung\n deren elektronischen einheitlichen Dokumentenakkreditiv-Regeln (eUCP-500).\nHaben Sie das elektronische Format gepr�ft ?";
g_arrConfirmationMessages[22] = "Sie sind im Begriff %s Rekorden zu einreichen. Sind Sie sicher ?";
g_arrConfirmationMessages[23] = "Die �nderung des Produkts wird die Anordnung des Berichts l�schen.\nSind Sie sicher ?";
g_arrConfirmationMessages[24] = "Der Parameter %s ist benutzt in ein oder mehrere Kriterium(en). \nDie L�schung dieses Elements wird auch das(die) verbunden(en) Kriterium(en) l�schen. \nSind Sie sicher?";
g_arrConfirmationMessages[25] = "Sie sind im Begriff %s Rekorden zu herunterladen. Sind Sie sicher ?";
g_arrConfirmationMessages[26] = "Der Herkunftsort oder der Bestimmungsort wird nicht eingegeben. \nSind Sie sicher ?";
g_arrConfirmationMessages[27] = "Sie sind im Begriff die aktuelle Akte durch TELEX zu einreichen. \n Sind Sie sicher ?";
g_arrConfirmationMessages[28] = "Der Parameter %s ist benutzt in ein oder mehrere Kriterium(en). \nDieses Elements umbenennen wird auch das(die) verbunden(en) Kriterium(en) l�schen. \nSind Sie sicher?";
g_arrConfirmationMessages[29] = "Dieses errechnete Feld ist benutzt in ein oder mehrere Aggregat(e). \nDieses Elements umbenennen wird auch das(die) verbunden(en) Aggregat(e) l�schen. \nSind Sie sicher?";

//
// Information messages
//
g_arrInformationMessages = new Array();

g_arrInformationMessages[1] = "Meldung aus der Bank :\n\n%s";


  // Utility to substitute the %s appearing in the message definition with the actual text
  function fncPrepareMessage(strTempMessage, strText1, strText2, strText3, strText4, strText5) 
  {
    if (strText1)
    {
      strTempMessage = strTempMessage.replace(/%s/,strText1);
      if (strText2)
      {
        strTempMessage = strTempMessage.replace(/%s/,strText2);
        if (strText3) 
        {
          strTempMessage = strTempMessage.replace(/%s/,strText3);
          if (strText4) 
          {
            strTempMessage = strTempMessage.replace(/%s/,strText4);
            if (strText5) 
              strTempMessage = strTempMessage.replace(/%s/,strText5);
          }
        }
      }
    }
    return strTempMessage;
  }

  // Displays an error box for the error code passed as input parameter
  function fncShowError(intErrorCode, strText1, strText2, strText3, strText4, strText5) 
  {
    var strErrorMessage = g_arrErrorMessages[intErrorCode];
    window.alert("ERROR - " + fncPrepareMessage(strErrorMessage, strText1, strText2, strText3, strText4, strText5));
  }

  // Displays a confirmation popup window returning true if the user clicks OK
  // and false otherwise
  function fncShowConfirmation(intMessageCode, strText1, strText2, strText3, strText4, strText5) 
  {
    var strConfirmationMessage = g_arrConfirmationMessages[intMessageCode];
    return window.confirm(fncPrepareMessage(strConfirmationMessage, strText1, strText2, strText3, strText4, strText5));
  }
  // Displays an information popup window
  function fncShowInformation(intMessageCode, strText1, strText2, strText3, strText4, strText5) 
  {
    var strInformationMessage = g_arrInformationMessages[intMessageCode];
    alert(fncPrepareMessage(strInformationMessage, strText1, strText2, strText3, strText4, strText5));
  }

