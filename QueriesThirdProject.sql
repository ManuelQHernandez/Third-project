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
