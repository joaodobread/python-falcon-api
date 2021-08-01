CREATE  TABLE "public".customer ( 
	user_id              uuid  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	deleted_at           timestamp   ,
	geolocation          point  NOT NULL ,
	route_id             uuid  NOT NULL ,
	CONSTRAINT pk_customer_user_id PRIMARY KEY ( user_id ),
	CONSTRAINT unq_customer_route_id UNIQUE ( route_id ) 
 );

CREATE  TABLE "public".routes ( 
	id                   uuid  NOT NULL ,
	created_by           uuid  NOT NULL ,
	bounds               polygon  NOT NULL ,
	selled_id            uuid  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	deleted_at           timestamp   ,
	is_default           boolean DEFAULT false NOT NULL ,
	CONSTRAINT pk_routes_id PRIMARY KEY ( id ),
	CONSTRAINT unq_routes_created_by UNIQUE ( created_by ) ,
	CONSTRAINT unq_routes_selled_id UNIQUE ( selled_id ) 
 );

CREATE  TABLE "public".seller ( 
	user_id              uuid  NOT NULL ,
	email                varchar(300)  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp  ,
	updated_at           date   ,
	deleted_at           date   ,
	CONSTRAINT pk_seller_user_id PRIMARY KEY ( user_id )
 );

CREATE  TABLE "public".tbl ( 
 );

CREATE  TABLE "public".user_has_roles ( 
	role_id              uuid  NOT NULL ,
	user_id              uuid  NOT NULL ,
	CONSTRAINT unq_user_has_roles_role_id UNIQUE ( role_id ) ,
	CONSTRAINT unq_user_has_roles_user_id UNIQUE ( user_id ) 
 );

CREATE UNIQUE INDEX unq_user_has_roles ON "public".user_has_roles ( role_id, user_id );

CREATE  TABLE "public".users ( 
	id                   uuid  NOT NULL ,
	name                 varchar(300)  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	deleted_at           timestamp   ,
	CONSTRAINT pk_users_id PRIMARY KEY ( id )
 );

CREATE UNIQUE INDEX idx_users ON "public".users ( id, deleted_at );

CREATE  TABLE "public".roles ( 
	id                   uuid  NOT NULL ,
	slug                 varchar(100)  NOT NULL ,
	description          varchar(500)   ,
	is_default           boolean DEFAULT false NOT NULL ,
	CONSTRAINT pk_roles_id PRIMARY KEY ( id )
 );

ALTER TABLE "public".roles ADD CONSTRAINT fk_roles_user_has_roles FOREIGN KEY ( id ) REFERENCES "public".user_has_roles( role_id );

ALTER TABLE "public".routes ADD CONSTRAINT fk_routes_customer FOREIGN KEY ( id ) REFERENCES "public".customer( route_id );

ALTER TABLE "public".seller ADD CONSTRAINT fk_seller_routes FOREIGN KEY ( user_id ) REFERENCES "public".routes( selled_id );

ALTER TABLE "public".users ADD CONSTRAINT fk_users_customer FOREIGN KEY ( id ) REFERENCES "public".customer( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "public".users ADD CONSTRAINT fk_users_seller FOREIGN KEY ( id ) REFERENCES "public".seller( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "public".users ADD CONSTRAINT fk_users_user_has_roles FOREIGN KEY ( id ) REFERENCES "public".user_has_roles( user_id );

ALTER TABLE "public".users ADD CONSTRAINT fk_users_routes FOREIGN KEY ( id ) REFERENCES "public".routes( created_by );

