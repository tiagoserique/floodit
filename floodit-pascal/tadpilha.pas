unit tadpilha;

interface

const
	maxTam = 1000;
type
	Tcoord = record
		x,y:integer;
		end;

	Tpilha = record
		item: array [1 .. maxTam] of Tcoord;
		top: integer;
		end;

function pilhaCheia(var p:Tpilha):boolean;
//Pilha cheia

function pilhaVazia(var p:Tpilha):boolean;
//Pilha vazia

function pop(var p:Tpilha):Tcoord;
//Desempilha

procedure push(var p:Tpilha; val:Tcoord);
//Empilha

procedure criaPilha(var p:Tpilha);
//Inicializa pilha

implementation


function pilhaCheia(var p:Tpilha):boolean;
begin
	pilhaCheia:=p.top = maxTam;
end;


function pilhaVazia(var p:Tpilha):boolean;
begin
        pilhaVazia:= p.top = 0;
end;


function pop(var p:Tpilha):Tcoord;
begin
	if (not pilhaVazia(p)) then
	begin
		pop.x:=p.item[p.top].x;
		pop.y:=p.item[p.top].y;
		p.top:=p.top-1;
	end
	else
		writeln('ERRO - Pilha vazia');
end;


procedure push(var p:Tpilha; val:Tcoord);
begin
	if (p.top <> maxTam) then
	begin
		p.top:=p.top+1;
		p.item[p.top].x:=val.x;
		p.item[p.top].y:=val.y;
	end
	else
		writeln('ERRO - pilha cheia');
end;


procedure criaPilha(var p:Tpilha);
begin
	p.top:=0;
end;

end.
