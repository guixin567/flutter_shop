import 'package:flutter/material.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/common/widget/TagText.dart';

class ProductContent extends StatefulWidget {
  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              "https://pics1.baidu.com/feed/d000baa1cd11728b44c88c72088c0dcac2fd2c69.jpeg?token=8656287e270397ed747373fe00e7ec0d&s=A3F2CB24F8A0DA07197CA5DA0100C092",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Apple/苹果 13 英寸 Macbook Pro 1.4GHz 四核处理器 (Turbo Boost 最高可达 3.9GHz) 256GB 存储容量 触控栏和触控 ID",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenHelper.size(28),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Apple/苹果 13 英寸 Macbook Pro 1.4GHz 四核处理器 (Turbo Boost 最高可达 3.9GHz) 256GB 存储容量 触控栏和触控 ID",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenHelper.size(20),
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Stack(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("特价"),
                  Text(
                    "￥28",
                    style: TextStyle(
                        color: Colors.red, fontSize: ScreenHelper.size(44)),
                  ),
                ],
              ),
              Positioned(
                height: ScreenHelper.height(60),
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("原价"),
                    Text(
                      "￥98",
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: (){
              showModalBottomSheet(context: context, builder: (context){
                return Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("颜色"),
                            TagText("黑色"),
                            TagText("白色"),
                            TagText("红色"),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              onPressed: (){},
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              child: Text("加入购物车"),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              onPressed: (){},
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              child: Text("立即购买"),
                            ),
                          )
                        ],
                      ),
                      width: ScreenHelper.screenWidthDp,
                      bottom: 0,
                    )
                  ],
                );
              });
            },
            child: Row(
              children: <Widget>[
                Text(
                  "已选：",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("115黑色,XL,1件")
              ],
            ),
          ),
          Divider(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text(
                "运费：",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("免费")
            ],
          ),
          Divider(
            height: 20,
          ),
        ],
      ),
    );
  }
}
