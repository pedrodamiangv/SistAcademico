/*Aca se presentan las acciones básicas para lavar un coche*/

/*En esta parte estan las acciones para lavar la carroceria*/
accion(agarrar_manguera,[carroceria_sucia,sin_objeto],[manguera],[sin_objeto]).

accion(pre_enjuague,[carroceria_sucia,manguera],[carroceria_enjuagada],[carroceria_sucia]).

accion(soltar_manguera,[carroceria_enjuagada,manguera],[sin_objeto],[manguera]).

accion(agarrar_esponja_enjabonada,[carroceria_enjuagada,sin_objeto],[esponja_enjabonada],[sin_objeto]).

accion(enjabonar_carroceria,[carroceria_enjuagada,esponja_enjabonada],[carroceria_enjabonada],[carroceria_enjuagada]).

accion(soltar_esponja_enjabonada,[carroceria_enjabonada,esponja_enjabonada],[sin_objeto],[esponja_enjabonada]).

accion(agarrar_panho_seco,[carroceria_enjabonada,sin_objeto],[panho_seco],[sin_objeto]).

accion(secado_carroceria,[carroceria_enjabonada,panho_seco],[carroceria_limpia],[carroceria_enjabonada]).

accion(soltar_panho,[carroceria_limpia,panho_seco],[sin_objeto],[panho_seco]).

/*Estas son las acciones para lavar*/
accion(agarrar_aspiradora,[interior_sucio,sin_objeto],[aspiradora],[sin_objeto]).

accion(aspirar_interior,[interior_sucio,aspiradora],[interior_limpio],[interior_sucio]).

accion(soltar_aspiradora,[interior_limpio,aspiradora],[sin_objeto],[aspiradora]).
