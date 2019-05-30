class Article{
  final String text;
  final String domain;
  final String by;
  final String age;
  final int score;
  final int commentsCount;

  const Article({
    this.text,
    this.domain,
    this.by,
    this.age,
    this.score,
    this.commentsCount
  });
}

final articles = [
  new Article(
    text: 'Thanks I got by using .then((param) { print(param); }) approach but as we do in android java while getting value from shared preference it comes directly to value Is there any way to do same in flutter.',
    domain: 'autoleader1.info',
    by: 'zdw',
    age: '3 hours',
    score: 177,
    commentsCount: 62,
  ),
  new Article(
    text: 'Create beautiful apps faster with Flutter’s collection of visual, structural, platform, and interactive widgets. In addition to browsing widgets by category, you can also see all the widgets in the widget index.',
    domain: 'autoleader1.info',
    by: 'Monokay',
    age: '2 hours',
    score: 2,
    commentsCount: 3,
  ),
  new Article(
    text: 'A widget that annotates the widget tree with a description of the meaning of the widgets. Used by accessibility tools, search engines, and other semantic analysis software to determine the meaning of the application.',
    domain: 'autoleader1.info',
    by: 'wb',
    age: '31 hour',
    score: 23,
    commentsCount: 100,
  ),
  new Article(
    text: 'If container is true, this widget will introduce a new node in the semantics tree. Otherwise, the semantics will be merged with the semantics of any ancestors (if the ancestor allows that). [...]',
    domain: 'autoleader1.info',
    by: 'zdw',
    age: '3 hours',
    score: 177,
    commentsCount: 62,
  ),
  new Article(
    text: 'GitLab is a single application for the entire software development lifecycle. From project planning and source code management to CI/CD, monitoring, and security.',
    domain: 'autoleader1.info',
    by: 'Monokay',
    age: '2 hours',
    score: 2,
    commentsCount: 3,
  ),
  new Article(
    text: 'From project planning and source code management to CI/CD and monitoring, GitLab is a single application for the entire DevOps lifecycle. Only GitLab enables Concurrent DevOps to make the software lifecycle 200% faster.',
    domain: 'autoleader1.info',
    by: 'wb',
    age: '31 hour',
    score: 23,
    commentsCount: 100,
  ),
];