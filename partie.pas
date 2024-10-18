unit Partie;

interface

uses typeDonnees, affichageJeu, dictionnaire, crt, animation, ScoreManager, SDL2, SDL2_ttf;


procedure partieJeu(mode: TDifficulte; renderer: PSDL_Renderer; font: PTTF_Font);
function initMot(mode: TDifficulte): TMot;
procedure modeDifficulte(var mode: TDifficulte);

implementation

function initMot(mode: TDifficulte): TMot;
    var i: Integer;

    begin
        Randomize;

        if mode = facile then
            initMot.chaine := motsFaciles[Random(10) + 1]
        else if mode = moyen then
            initMot.chaine := motsMoyens[Random(10) + 1]
        else
            initMot.chaine := motsDifficiles[Random(10) + 1];

        initMot.longueurMot := length(initMot.chaine);

        setLength(initMot.cache, initMot.longueurMot);

        for i := 1 to initMot.longueurMot do
            initMot.cache[i] := True;
    end;


procedure modeDifficulte(var mode: TDifficulte);
    var input: Integer;

    begin
        repeat
            ClrScr;
            animate('🤔 DIFFICULTÉ', 50, True);
            writeln('');
            writeln('1. Facile  2. Moyen  3. Difficile');
            writeln('');
            write('Niveau: ');
            read(input);

            case input of
                1: mode := facile;
                2: mode := moyen;
            else
                mode := difficile;
            end;

        until (input >= 1) and (input <= 3);
    end;


procedure partieJeu(mode: TDifficulte; renderer: PSDL_Renderer; font: PTTF_Font);
    var mot: TMot;
    var tentativeWord: string;
    var key: Char;
    var valide: Boolean;
    var tentatives, i: Integer;
    var scoreManager: TScoreManager;
    var running: boolean;
    var event: SDL_event;
    
    begin
        tentatives := 0;
        valide := False;
        mot := initMot(mode);
        InitScoreManager(scoreManager, 7, mot.chaine);
        tentativeWord := '';
        running := True;
        
        while running and not partieGagnee(mot) and (tentative < 7) do
        begin
            while SDL_PollEvent(@event) = 1 do
            begin
                case event.type_ of
                    SDL_Quit: running := False;
                    SDL_KEYDOWN:
                    begin
                        if event.key.keysym.sym = SDLK_RETURN then
                        begin
                            if tentativeWord = mot.chaine then
                            begin
                                valide := True;
                                break;
                            end
                            else
                            begin
                                tentatives := tentatives + 1;
                                tentativeWord := '';
                            end;
                        end
                        else if (event.key.keysym.sym >= SDLK_a) and (event.key.keysym.sym <= SDLK_z) then
                        begin
                            if Length(tentativeWord) < mot.longeurMot then
                                tentativeWord := tentativeWord + Chr(event.key.keysym.sym);
                            end;
                        end;
                    end;
                end;

                ClrScr;
                writeln('Mot entrée : ', tentativeWord);
                writeln('Tentatives restantes : ', 7 - tentatives);

                SDL_Delay(500);
            end;

            if partieGagnee(mot) then
                animate('Partie gagnée 🏆', 50, True);
            else
                animate('Partie perdue 💀', 50, True);
                
            RenderFinalScore(renderer, font, scoreManager);
            delay(4000);
        end;
    end;
    
end.
