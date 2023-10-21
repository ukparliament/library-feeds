drop table if exists articles;


create table articles (
	id serial,
	title varchar(500) not null,
	author varchar(255),
	link varchar(255) not null,
	published_at timestamp not null,
	guid varchar(255) not null,
	is_posted_to_bluesky boolean default false,
	is_posted_to_mastodon boolean default false,
	primary key (id)
);