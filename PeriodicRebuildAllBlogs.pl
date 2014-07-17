package MT::Plugin::PeriodicRebuildAllBlogs;

use MT;
use MT::Task;
use MT::WeblogPublisher;

use base qw( MT::Plugin );

my $plugin = new MT::Plugin({
  name => 'PeriodicRebuildAllBlogs',
  key => 'PeriodicRebuildAllBlogs',
  author_name => 'Suzuki Toshinari',
  author_link => 'http://suzuki.toshinari.jp/',
  version => '0.1',
  description => 'run-periodic-rebuildが実行された時に全てのブログを再構築します。'
});

MT->add_plugin($plugin);

MT->add_task(new MT::Task({
  name => 'PeriodicRebuildAllBlogs',
  key => 'PeriodicRebuildAllBlogs',
  frequency => 10,
  code => \&rebuild_all_blogs
}));

sub rebuild_all_blogs{
  my $rbld = MT::WeblogPublisher->new;
  my $iter = MT->model('blog')->load_iter();

  while(my $blog = $iter->()){
    $rbld->rebuild(
      BlogID => $blog->id
    );
  }
}

1;
