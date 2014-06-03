module dcc.curses.cli;

private import std.stdio;
private import std.string;
private import std.regex;
private import std.utf : count;
private import std.conv : to;
private import std.algorithm : filter, sort, find;
private import std.file : exists, copy;
private import std.process : environment;

private import core.thread;

private import dcc.engine.tribune;

extern (C) { char* setlocale(int category, const char* locale); }

void main(string[] args) {
	setlocale(0, "".toStringz());

	string backend = "";
	bool tags_encoded = false;
	if (args.length > 2 && args[1] == "-t") {
		tags_encoded = true;
		backend = args[2];
	} else {
		backend = args[1];
	}

	Tribune tribune = new Tribune(backend, tags_encoded);

	tribune.on_new_post ~= delegate(Post post) {
		writefln("%s\t%s\t%s\t%s\t%s", post.post_id, post.tribune_time, post.info, post.login, post.message);
	};

	tribune.fetch_posts();
}

