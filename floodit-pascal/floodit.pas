program floodit;
uses CRT, tadpilha;
const
	max = 1000;
	space = '      ';
type
	Tboard = record
		mat:array [0 .. max+1, 0 .. max+1] of integer;
		tam,nmoves,maxmoves:integer;
		end;
	
	Tcolor = record
		ncolors,next_color,previous_color:integer;
		end;



function victory(board:Tboard):boolean;
var
	i,j,cont: integer;
begin
	victory:=false;
	i:=0;
	cont:=0;
	while (i < board.tam) do
	begin
		i:=i+1;
		j:=0;
		while (j < board.tam) do
		begin
			j:=j+1;
			if (board.mat[1,1] = board.mat[i,j]) then
				cont:=cont+1;		
		end;
	end;
	if (cont = board.tam*board.tam) then
		victory:=true;
end;


function flood_neighbor(var board:Tboard; color:Tcolor; map:Tcoord):boolean;
begin
	flood_neighbor:=false;
	if (board.mat[map.x,map.y] = color.previous_color) then
	begin
		board.mat[map.x,map.y]:=color.next_color;
		flood_neighbor:=true;
	end;
end;


procedure flood_it(var board:Tboard; color:Tcolor);
var
	neighbors:Tpilha;
	map:Tcoord;
begin
	criaPilha(neighbors);
	map.x:=1;
	map.y:=1;
	board.mat[1,1]:=color.next_color;
	push(neighbors,map);

	while (not pilhaVazia(neighbors)) do
	begin
		map:=pop(neighbors);
		
		//Left
		map.y:=map.y-1;
		if flood_neighbor(board,color,map) then
			push(neighbors,map);
		
		//Right
		map.y:=map.y+2;
		if flood_neighbor(board,color,map) then
			push(neighbors,map);
		
		//Up
		map.y:=map.y-1;
		map.x:=map.x-1;
		if flood_neighbor(board,color,map) then
			push(neighbors,map);
	
		//Down
		map.x:=map.x+2;
		if flood_neighbor(board,color,map) then
			push(neighbors,map);
	end;
end;


procedure show_board(board: Tboard; won,lost:boolean);
var
	i,j:integer;
begin
	clrscr;
	writeln;
	writeln;
	writeln(space,space,board.nmoves,'/',board.maxmoves);
	writeln;
	writeln;

	for i:=1 to board.tam do
	begin
		for j:=1 to board.tam do
		begin
			if (j <> 1) then
			begin
				textbackground(board.mat[i,j]);
				write(' ',board.mat[i,j],' ');
				textbackground(black);
			end
			else
			begin
				write(space);
				textbackground(board.mat[i,j]);
				write(' ',board.mat[i,j],' ');
				textbackground(black);
			end;
		end;
		writeln;
	end;
	
	writeln;
	writeln;	
	
	if (won) then
		writeln(space,space,'GANHOU')
	else if (lost) then
		writeln(space,space,'PERDEU');
end;


procedure init_board(var board: Tboard; color:Tcolor);
var
	i,j:integer;
begin
	randomize;
	for i:=0 to (board.tam+1) do
		for j:=0 to (board.tam+1) do
			if (i <> 0) and (j <> 0) and (i <> board.tam+1) and 
			(j <> board.tam+1) then
				board.mat[i,j]:=random(color.ncolors)+1
			else
				board.mat[i,j]:= -1;
end;


procedure init_specifications(var board:Tboard; var color:Tcolor);
begin
	writeln('Size of the board: 6 - 14 - 18 - 26');
	read(board.tam);
	writeln('Number of colors: 4 - 6 - 8');
	read(color.ncolors);
	
	case board.tam of
		6:begin
			if (color.ncolors = 4) then
				board.maxmoves:=7
			else if (color.ncolors = 6) then
				board.maxmoves:=10
			else 
				board.maxmoves:=14;
		end;
	
		14:begin
			if (color.ncolors = 4) then
				board.maxmoves:=16
			else if (color.ncolors = 6) then
				board.maxmoves:=25
			else
				board.maxmoves:=33;
		end;
	
		18:begin
			if (color.ncolors = 4) then
				board.maxmoves:=21
			else if (color.ncolors = 6) then
				board.maxmoves:=32
			else
				board.maxmoves:=42;
		end;
	
		26:begin
			if (color.ncolors = 4) then
				board.maxmoves:=30
			else if (color.ncolors = 6) then
				board.maxmoves:=46
			else
				board.maxmoves:=61;
		end;
	end;
end;


var
	board: Tboard;
	color:Tcolor;
	won,lost:boolean;
begin
	init_specifications(board,color);
	init_board(board,color);
	
	won:=false;
	lost:=false;
	board.nmoves:=0;
	color.previous_color:=board.mat[1,1];

	while (not won) and (not lost) do
	begin
		show_board(board,won,lost);
		read(color.next_color);

		if (color.next_color <> color.previous_color) and 
		(color.next_color <= color.ncolors) then
		begin
			board.nmoves:=board.nmoves+1;
			flood_it(board,color);
		end;
		
		if (board.nmoves = board.maxmoves) and (not victory(board)) then
			lost:=true
		else if (board.nmoves = board.maxmoves) then
			won:=true;

		color.previous_color:=color.next_color;
	end;
	show_board(board,won,lost);
end.
