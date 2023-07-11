use WWW::Telegram::BotAPI;
my $api = WWW::Telegram::BotAPI->new (
    token => 'my_token'
);
# The API methods die when an error occurs.
say $api->getMe->{result}{username};
# ... but error handling is available as well.
my $result = eval { $api->getMe }
    or die 'Got error message: ', $api->parse_error->{msg};
# Uploading files is easier than ever.
$api->sendPhoto ({
    chat_id => 123456,
    photo   => {
        file => '/home/me/cool_pic.png'
    },
    caption => 'Look at my cool photo!'
});
# Complex objects are as easy as writing a Perl object.
$api->sendMessage ({
    chat_id      => 123456,
    # Object: ReplyKeyboardMarkup
    reply_markup => {
        resize_keyboard => \1, # \1 = true when JSONified, \0 = false
        keyboard => [
            # Keyboard: row 1
            [
                # Keyboard: button 1
                'Hello world!',
                # Keyboard: button 2
                {
                    text => 'Give me your phone number!',
                    request_contact => \1
                }
            ]
        ]
    }
});
# Asynchronous request are supported with Mojo::UserAgent.
$api = WWW::Telegram::BotAPI->new (
    token => 'my_token',
    async => 1 # WARNING: may fail if Mojo::UserAgent is not available!
);
$api->sendMessage ({
    chat_id => 123456,
    text    => 'Hello world!'
}, sub {
    my ($ua, $tx) = @_;
    die 'Something bad happened!' if $tx->error;
    say $tx->res->json->{ok} ? 'YAY!' : ':('; # Not production ready!
});
Mojo::IOLoop->start;