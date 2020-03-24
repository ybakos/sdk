// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_fe_analyzer_shared/src/scanner/token.dart';
import 'package:analyzer/dart/ast/ast.dart';

/// Determine if the given token is a nullability hint, and if so, return the
/// type of nullability hint it is.
NullabilityComment classifyComment(Token token) {
  if (token is CommentToken) {
    if (token.lexeme == '/*!*/') return NullabilityComment.bang;
    if (token.lexeme == '/*?*/') return NullabilityComment.question;
  }
  return NullabilityComment.none;
}

/// Determine if the given [node] is followed by a nullability hint, and if so,
/// return the type of nullability hint it is followed by.
NullabilityComment getPostfixHint(AstNode node) {
  var commentToken = node.endToken.next.precedingComments;
  var commentType = classifyComment(commentToken);
  return commentType;
}

/// Types of comments that can influence nullability
enum NullabilityComment {
  /// The comment `/*!*/`, which indicates that the type should not have a `?`
  /// appended.
  bang,

  /// The comment `/*?*/`, which indicates that the type should have a `?`
  /// appended.
  question,

  /// No special comment.
  none,
}
