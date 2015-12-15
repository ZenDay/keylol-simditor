
class ParagraphButton extends Button

  name: 'paragraph'

  htmlTag: 'h1, p, comment'

  disableTag: 'pre, table'

  _init: ->
    @menu = [{
      name: 'heading',
      text: '标题',
      param: 'h1'
    }, {
      name: 'normal',
      text: '正文',
      param: 'p'
    }, {
      name: 'comment',
      text: '注释',
      param: 'comment'
    }]
    super()

  setActive: (active, param) ->
    param ||= @node[0].tagName.toLowerCase() if active
    @el.removeClass 'active-h1 active-comment'
    return super false if param is 'p'
    super active
    @el.addClass('active-' + param) if active

  command: (param) ->
    $rootNodes = @editor.selection.rootNodes()
    @editor.selection.save()


    $rootNodes.each (i, node) =>
      $node = $ node
      return if $node.is('blockquote') or $node.is(param) or
        $node.is(@disableTag) or @editor.util.isDecoratedNode($node)

      $('<' + param + '/>').append($node.contents())
      .replaceAll($node)

    @editor.selection.restore()
    @editor.trigger 'valuechanged'


Simditor.Toolbar.addButton ParagraphButton
