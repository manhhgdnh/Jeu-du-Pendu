unit Parametres;

interface

uses typeDonnees, crt, other;

procedure parametresJeu(theme: TTheme);
procedure afficherScore(nomFichier: String);
procedure choisirTheme(var theme: TTheme);

implementation

procedure afficherScore(nomFichier: String);
    var resultat: TResultat;
    var fichier: File of TResultat;
    
    begin
        assign(fichier, nomFichier);
        reset(fichier);

        while not EOF(fichier) do
        begin
            read(fichier, resultat);
            with resultat do
            begin
            writeln('Mot: ', resultat.mot);
            writeln('Score: ', resultat.score);
            writeln('Gagné: ', resultat.gagne);
            writeln('------------------------');
            end;
    end;

    close(fichier);
    end;


procedure choisirTheme(var theme: TTheme);
    var choix: Integer;

    begin
        repeat
            ClrScr;
            animate('✨ THÈME');
            writeln('');

            write('1. Light');
            if theme = light then
                write(' ✅');
                
            write('  2. Dark');
            if theme = dark then
                write(' ✅');

            write('  3. High Contrast');
            if theme = high_contrast then
                write(' ✅ ');

            writeln('');
            writeln('');

            write('Choix: ');
            read(choix);

            if ((choix >= 1) and (choix <= 3)) = false then
                begin
                    ClrScr;
                    animate('❌ Saisie incorrecte...');
                    delay(750);
                end;
        until (choix >= 1) and (choix <= 3);

        if choix = 1 then
            begin
                theme := light;
                TextBackground(white);
                TextColor(black);
                ClrScr;
                animate('✅ Light Mode');
                delay(750);
            end
        else if choix = 2 then
            begin
                theme := dark;
                TextBackground(black);
                TextColor(lightgray);
                ClrScr;
                animate('✅ Dark Mode');
                delay(750);
            end
        else if choix = 3 then
            begin
                theme := high_contrast;
                TextBackground(yellow);
                TextColor(blue);
                ClrScr;
                animate('✅ High Contrast');
                delay(750);
            end;
    end;


procedure parametresJeu(theme: TTheme);
    var input: Integer;

    begin
        repeat
            ClrScr;

            animate('🕹️ PARAMÈTRES');
            writeln('');
            writeln('1. Afficher les scores');
            writeln('2. Choisir le thème');
            writeln('3. Revenir au menu');
            writeln('');
            write('Entrée: ');
            read(input);

            ClrScr;

            if input = 1 then
                writeln('Affichage du score...')
            else if input = 2 then
                choisirTheme(theme)
            else if input <> 3 then
                begin
                    animate('❌ Saisie incorrecte...');
                    delay(750);
                end;

        until input = 3;
    end;

end.
