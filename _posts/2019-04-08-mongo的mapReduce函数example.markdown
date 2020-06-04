---
layout: post
title:  "mongo的mapReduce函数example"
date:   2019-04-08 09:00:00 +0800
categories: code
---
1. mongo的查询语句与js的函数神似;
2. 函数案例来源 [http://blog.csdn.net/yyywyr/article/details/26287483][yyywyr-blog-url]

```js
m = function (){
    // 只拿包含x的
    if(this.identityNumber.indexOf("x") != -1){
        emit(this._id, this);
    }
};

r = function(key, values) {
    return values.identityNumber.replace(/x/g, "X");
};

db.getCollection('declare_report_copy1027').mapReduce(m, r, "declare_report_copy1027");
```
查询替换结果都是为`{_id: XXX, value: {XXX: XXX ...}}`这种形式的结构.
分析只适合用于count一些特殊条件的计数.

[yyywyr-blog-url]: http://blog.csdn.net/yyywyr/article/details/26287483