unit ScoreManager;

interface

uses SDL2, SysUtils, SDL2_ttf, typeDonnees;

type 
	TScoreManager = record
		resultat: TResultat;
		lostAttempts: integer;
		maxAttemptsUser : integer;
	end;
	

procedure InitScoreManager(var scoreManager: TScoreManager; maxAttempts: integer; mot: string);
procedure CalculateScore(var scoreManager: TScoreManager; isCorrect: boolean);
procedure ResetScore(var scoreManager: TScoreManager);
procedure RenderFinalScore(renderer: PSDL_Renderer; font: PTTF_Font; var scoreManager: TScoreManager);

implementation


procedure InitScoreManager(var scoreManager: TScoreManager; maxAttempts: integer; mot: string);
begin
	scoreManager.resultat.score := 0;
	scoreManager.lostAttemps := 0;
	scoreManager.maxAttemptsUser := maxAttempts;
	scoreManager.resultat.mot := mot;
	scoreManager.resultat.gagne := False;
end;

procedure CalculateScore(var scoreManager: TScoreManager; isCorrect: boolean);
var
	points : integer;
begin	
	if isCorrect then
		scoreManager.resultat.score := scoreManager.resultat.score + 10;
	else
	begin
		scoreManager.resultat.score := scoreManager.resultat.score - 5;
		if scoreManager.resultat.score < 0 then
		scoreManager.resultat.score := 0;
		scoreManager.lostAttempts := scoreManager.lostAttempts +1;
	end;
end;

procedure ResetScore(var scoreManager: TScoreManager);
begin
	scoreManager.resultat.score := 0;
	scoreManager.lostAttempts := 0;
end;

procedure RenderFinalScore(renderer: PSDL_Renderer; font: PTTF_Font; var scoreManager: TScoreManager);
var
	scoreText: string;
	surface: PSDL_Surface;
	texture: PSDL_Texture;
	color: TSDL_Color;
	destRect: TSDL_Rect;
begin
	color.r := 255;
	color.g := 255;
	color.b := 255;
	
	scoreText := 'Score : ' + IntToStr(scoreManager.resultat.score);
	surface := TTF_RenderText_Solid(font, PAnsiChar(AnsiString(scoreText)), color);
	
	if surface = nil then
	begin
		writeln('Error creating surface :', SDL_GetError);
		exit;
	end;
	
	texture := SDL_CreateTextureFromSurface(renderer, surface);
	if texture = nil then
	begin
		writeln('Error creating texture: ', SDL_GetError);
		SDL_FreeSurface(surface);
		exit;
	end;
	
	destRect.x := 300;
	destRect.y := 200;
	destRect.w := surface^.w;
	destRect.h := surface^.h;
	
	SDL_RenderCopy(renderer, texture, nil, @destRect);
	SDL_RenderPresent(renderer);
	SDL_DestroyTexture(texture);
	SDL_FreeSurface(surface);
end;

end.

	
		
		























