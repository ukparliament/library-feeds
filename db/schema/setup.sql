drop table if exists articles;
drop table if exists publishers;


create table publishers (
	id serial,
	name varchar(500) not null,
	primary key (id)
);

create table articles (
	id serial,
	title varchar(500) not null,
	author varchar(255),
	link varchar(255) not null,
	published_at timestamp not null,
	guid varchar(255) not null,
	is_posted_to_bluesky boolean default false,
	is_posted_to_mastodon boolean default false,
	publisher_id int not null,
	constraint fk_publisher foreign key (publisher_id) references publishers(id),
	primary key (id)
);