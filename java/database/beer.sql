BEGIN TRANSACTION;

DROP TABLE IF EXISTS brewery_beer, beer, brewery;

CREATE TABLE beer (
    beer_id serial NOT NULL,
    name varchar(64) NOT NULL,
    description varchar(120) NULL,
    style varchar(64) NULL,
    region varchar(64)  NULL,
    price money NULL,
    abv float(2) NULL,

    CONSTRAINT pk_beer PRIMARY KEY (beer_id)
);

CREATE TABLE brewery_beer (
    brewery_id int NOT NULL,
    beer_id int NOT NULL,

    CONSTRAINT pk_brewery_beer_brewery_id_beer_id PRIMARY KEY (brewery_id, beer_id),
    CONSTRAINT fk_brewery_beer_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id),
    CONSTRAINT fk_brewery_beer_beer_id FOREIGN KEY (beer_id) REFERENCES beer (beer_id)
);

COMMIT;
