program main;

uses crt, partie, parametres, typeDonnees, animation, SDL2, SDL2_ttf;

var input: Integer;
var mode: TDifficulte;
var theme: TTheme;
var window: PSDL_Window;
var renderer: PSDL_Renderer;
var font: PTTF_Font;

begin
    //Initialise SDL
    if SDL_Init(SDL_INIT_VIDEO) < 0 then
    begin
        writeln('Error initializing SDL: ', SDL_GetError);
        exit;
    end;

    if TTF_Init() = -1 then
    begin
        writeln('Error initializing SDL_ttf: ', TTF_GetError);
        SDL_Quit;
        exit;
    end;

    window := SDL_CreateWindow('Jeu du Pendu', SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1000, 800, SDL_WINDOW_SHOWN);
    if window = nil then
    begin
        writeln('Error creating window: ', SDL_GetError);
        SDL_Quit;
        exit;
    end;
    
    renderer := SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED or SDL_RENDERER_PRESENTVSYNC);
    if renderer = nil then
    begin
        writeln('Error creating renderer: ', SDL_GetError);
        SDL_DestroyWindow(window);
        SDL_Quit;
        exit;
    end;

    font := TTF_OpenFont('Arial.ttf', 26);
    if font = nil then
    begin
        writeln('Error loading font: ', TTF_GetError);
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit;
        exit;
    end;
    
    theme := dark;

    repeat
        begin
            ClrScr;
            animate('Bienvenu au Jeu du Pendu 🫥', 50, True);
            writeln('');
            writeln('1. Lancer une partie');
            writeln('2. Paramètres');
            writeln('3. Quitter');
            writeln('');
            write('>>> ');
            read(input);
            ClrScr;

            if input = 1 then
                begin
                    modeDifficulte(mode);
                    partieJeu(mode,renderer,font); //Ajouter renderer et font
                end
            else if input = 2 then
                parametresJeu(theme)
            else if input <> 3 then
                begin
                    ClrScr;
                    animate('❌ Saisie incorrecte...', 50, False);
                    delay(750);
                end;
        end;

    until input = 3;

    TTF_CloseFont(font);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    TTF_Quit;
    SDL_Quit;
end.
