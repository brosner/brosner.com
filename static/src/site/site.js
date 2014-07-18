$(function() {
    var $affixElement = $('div[data-spy="affix"]');
    $affixElement.width($affixElement.parent().width());
    var Post = Backbone.Model.extend({
        defaults: function() {
            return {
                a: 4
            };
        }
    });
    var PostCollection = Backbone.Collection.extend({
        model: Post,
        url: "/api/posts/",
        fetch: function(options) {
            this.trigger("fetch", this, options);
            return Backbone.Collection.prototype.fetch.call(this, options);
        }
    });
    var loading = Handlebars.compile($("#tmpl_loading").html());
    var posts = new PostCollection;
    posts.on("fetch", function() {
        $("#posts").html(loading({}));
    });
    var PostView = Backbone.View.extend({
        template: Handlebars.compile($("#tmpl_post").html()),
        render: function() {
            this.$el.html(this.template(this.model.attributes));
            return this;
        }
    });
    var AppView = Backbone.View.extend({
        el: $("#app"),
        initialize: function() {
            //this.listenTo(posts, "add", this.addOne);
            this.listenTo(posts, "reset", this.addAll);
            this.listenTo(posts, "all", this.render);
            posts.fetch({reset: true});
        },
        addOne: function(post) {
            var view = new PostView({model: post});
            this.$("#posts").append(view.render().el);
        },
        addAll: function() {
            $("#posts").empty();
            posts.each(this.addOne, this);
            twttr.widgets.load();
        },
    });
    var App = new AppView;
});
