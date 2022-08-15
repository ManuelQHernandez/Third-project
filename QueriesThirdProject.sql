/** Listado de jugadores que al menos han jugado una partida **/
select usp.name as name,  count(player.id_user) as Cantidad_Partidas 
from Games player, users_player usp 
where player.id_user = usp.id_user 
group by player.id_user, usp.name 
having count(*)=1;

/** Listado de jugadores que no han jugado una partida **/
select name, id_user
from users_player
where not exists (select * from Games where games.id_user = users_player.id_user);

/** Listado de jugadores que al menos han ganado una partida **/
select usp.name, count(stat.won) as Han_ganado_al_menos_una_partida 
from hangman_stats stat inner join users_player usp on usp.id_user = stat.id_user  
where stat.won = 1
group by usp.name;


/** Listado de jugadores que no han perdido una partida **/
select usp.name as Listado_de_jugadores_que_no_han_perdido_una_partida 
from hangman_stats stat inner join users_player usp on usp.id_user = stat.id_user  
where stat.lost = 0
group by usp.name;

/**Top 3 de los peores jugadores (partidas perdidas)**/
select e.id_user, count(e.lost) as Lost from (
select id_user, lost, row_number() over(order by lost) r from Hangman_stats where lost = 1)e
where e.r <=3 group by e.id_user, e.lost;


/** Top 3 de los mejores jugadores (partidas ganadas) **/
select usp.name, count(stat.won) as TOP_3_POR_PARTIDA_GANADA 
from hangman_stats stat inner join users_player usp on usp.id_user = stat.id_user  
where stat.won = 1
group by usp.name
FETCH FIRST 3 ROWS ONLY;

/** Top 3 de los mejores jugadores hangman **/
select usp.name as TOP_3_MEJORES_JUGADORES
from hangman_stats stat inner join users_player usp on usp.id_user = stat.id_user  
where stat.won = 1
group by usp.name
FETCH FIRST 3 ROWS ONLY;

/** Top 3 de los mejores jugadores ttt **/
select usp.name, count(stat.win) as TOP_3_POR_PARTIDA_GANADA_TTT 
from tictactoe_stats stat inner join users_player usp on usp.id_user = stat.id_user  
where stat.win = 1
group by usp.name
FETCH FIRST 3 ROWS ONLY;

/** Top 3 de los peores jugadores hangman **/
select usp.name as TOP_3_PEORES_JUGADORES_HANGMAN
from hangman_stats stat inner join users_player usp on usp.id_user = stat.id_user  
where  stat.won = 0
group by usp.name
FETCH FIRST 3 ROWS ONLY;

/** Top 3 de los peores jugadores ttt **/
select usp.name as TOP_3_PEORES_JUGADORES_TTT
from tictactoe_stats stat inner join users_player usp on usp.id_user = stat.id_user  
where  stat.win = 0
group by usp.name
FETCH FIRST 3 ROWS ONLY;

/** Jugador de TTT con menos tiros para ganar **/


/** Jugador de Hangman con menos intentos al ganar**/
select G.id_user as Player, M.try as Menos_Intentos
from words M 
join hangman H on H.id_hangman =M.id_word
join games G on G.id_game = H.id_game
join users_player U on U.id_user = G.id_user
join hangman_stats HS on HS.id_hangman = H.id_hangman
where M.try = 1 and HS.won =1;

/** Jugador de TTT con más tiros para ganar **/

/** Jugador de Hangman con mas intentos al ganar**/
select G.id_user as ID_user, U.name as Player, count(M.try) as Mas_Intentos
from words M 
join hangman H on H.id_hangman =M.id_word
join games G on G.id_game = H.id_game
join users_player U on U.id_user = G.id_user
join hangman_stats HS on HS.id_hangman = H.id_hangman group by G.id_user, U.name;

/** Promedio del tamaño de palabras utilizadas en Hangman **/


/** Mostrar Listado de los jugadores de Hangman y establecer 
si son mejores como guiver o guesser**/





