CREATE SCHEMA IF NOT EXISTS "stone-api";

CREATE  TABLE customer ( 
	user_id              uuid  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	deleted_at           timestamp   ,
	geolocation          point  NOT NULL ,
	CONSTRAINT pk_customer_user_id PRIMARY KEY ( user_id )
 );

CREATE  TABLE routes ( 
	id                   uuid  NOT NULL ,
	created_by           uuid  NOT NULL ,
	bounds               polygon  NOT NULL ,
	selled_id            uuid  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	deleted_at           timestamp   ,
	CONSTRAINT pk_routes_id PRIMARY KEY ( id ),
	CONSTRAINT unq_routes_created_by UNIQUE ( created_by ) ,
	CONSTRAINT unq_routes_selled_id UNIQUE ( selled_id ) 
 );

CREATE  TABLE seller ( 
	user_id              uuid  NOT NULL ,
	email                varchar(300)  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp  ,
	updated_at           date   ,
	deleted_at           date   ,
	CONSTRAINT pk_seller_user_id PRIMARY KEY ( user_id )
 );

CREATE  TABLE tbl ( 
 );

CREATE  TABLE user_has_roles ( 
	role_id              uuid  NOT NULL ,
	user_id              uuid  NOT NULL ,
	CONSTRAINT unq_user_has_roles_role_id UNIQUE ( role_id ) ,
	CONSTRAINT unq_user_has_roles_user_id UNIQUE ( user_id ) 
 );

CREATE UNIQUE INDEX unq_user_has_roles ON user_has_roles ( role_id, user_id );

CREATE  TABLE users ( 
	id                   uuid  NOT NULL ,
	name                 varchar(300)  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	deleted_at           timestamp   ,
	CONSTRAINT pk_users_id PRIMARY KEY ( id )
 );

CREATE UNIQUE INDEX idx_users ON users ( id, deleted_at );

CREATE  TABLE roles ( 
	id                   uuid  NOT NULL ,
	slug                 varchar(100)  NOT NULL ,
	description          varchar(500)   ,
	is_default           boolean DEFAULT false NOT NULL ,
	CONSTRAINT pk_roles_id PRIMARY KEY ( id )
 );

ALTER TABLE roles ADD CONSTRAINT fk_roles_user_has_roles FOREIGN KEY ( id ) REFERENCES user_has_roles( role_id );

ALTER TABLE seller ADD CONSTRAINT fk_seller_routes FOREIGN KEY ( user_id ) REFERENCES routes( selled_id );

ALTER TABLE users ADD CONSTRAINT fk_users_customer FOREIGN KEY ( id ) REFERENCES customer( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE users ADD CONSTRAINT fk_users_seller FOREIGN KEY ( id ) REFERENCES seller( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE users ADD CONSTRAINT fk_users_user_has_roles FOREIGN KEY ( id ) REFERENCES user_has_roles( user_id );

ALTER TABLE users ADD CONSTRAINT fk_users_routes FOREIGN KEY ( id ) REFERENCES routes( created_by );

