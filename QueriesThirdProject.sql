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


/**Top 3 de los peores jugadores (partidas perdidas)**/
select e.id_user, count(e.lost) as Lost from (
select id_user, lost, row_number() over(order by lost) r from Hangman_stats where lost = 1)e
where e.r <=3 group by e.id_user, e.lost;


/** Top 3 de los mejores jugadores (partidas ganadas) **/
select e.id_user, count(e.won) as Won
from (select id_user, won, row_number() over(order by won) r from Hangman_stats where won = 1)e
where e.r <=3 group by e.id_user, e.won;

/** Top 3 de los mejores jugadores hangman **/

/** Top 3 de los mejores jugadores ttt **/

/** Jugador de Hangman con menos intentos al ganar**/
select G.id_user as Player, M.try as Intentos
from words M 
join hangman H on H.id_hangman =M.id_word
join games G on G.id_game = H.id_game
join users_player U on U.id_user = G.id_user where M.try = 1;



