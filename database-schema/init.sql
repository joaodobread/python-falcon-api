CREATE  TABLE "public".roles ( 
	id                   uuid  NOT NULL ,
	slug                 varchar(100)  NOT NULL ,
	description          varchar(500)   ,
	is_default           boolean DEFAULT false NOT NULL ,
	CONSTRAINT pk_roles_id PRIMARY KEY ( id )
 );

CREATE UNIQUE INDEX unq_roles ON "public".roles ( slug );

CREATE  TABLE "public".users ( 
	id                   uuid  NOT NULL ,
	name                 varchar(300)  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	deleted_at           timestamp   ,
	CONSTRAINT pk_users_id PRIMARY KEY ( id )
 );

CREATE  TABLE "public".customers ( 
	user_id              uuid  NOT NULL ,
	"position"           point  NOT NULL ,
	CONSTRAINT pk_sellers_user_id PRIMARY KEY ( user_id )
 );

CREATE  TABLE "public".routes ( 
	id                   uuid  NOT NULL ,
	bounds               polygon  NOT NULL ,
	name                 varchar(200)  NOT NULL ,
	created_at           timestamp DEFAULT current_timestamp NOT NULL ,
	updated_at           timestamp   ,
	created_by           uuid  NOT NULL ,
	seller_id            uuid   ,
	CONSTRAINT pk_routes_id PRIMARY KEY ( id )
 );

CREATE  TABLE "public".sellers ( 
	user_id              uuid  NOT NULL ,
	email                varchar(200)  NOT NULL ,
	CONSTRAINT pk_customers_user_id PRIMARY KEY ( user_id )
 );

CREATE UNIQUE INDEX unq_customers_email ON "public".sellers ( email );

CREATE  TABLE "public".user_roles ( 
	user_id              uuid  NOT NULL ,
	role_id              uuid  NOT NULL ,
	CONSTRAINT unq_user_roles UNIQUE ( user_id, role_id ) 
 );

ALTER TABLE "public".customers ADD CONSTRAINT fk_sellers_users FOREIGN KEY ( user_id ) REFERENCES "public".users( id );

ALTER TABLE "public".routes ADD CONSTRAINT fk_routes_users FOREIGN KEY ( created_by ) REFERENCES "public".users( id );

ALTER TABLE "public".routes ADD CONSTRAINT fk_routes_sellers FOREIGN KEY ( seller_id ) REFERENCES "public".customers( user_id );

ALTER TABLE "public".sellers ADD CONSTRAINT fk_customers_users FOREIGN KEY ( user_id ) REFERENCES "public".users( id );

ALTER TABLE "public".user_roles ADD CONSTRAINT fk_user_roles_users FOREIGN KEY ( user_id ) REFERENCES "public".users( id );

ALTER TABLE "public".user_roles ADD CONSTRAINT fk_user_roles_roles FOREIGN KEY ( role_id ) REFERENCES "public".roles( id );

