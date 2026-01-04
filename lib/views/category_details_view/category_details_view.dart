import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';

class CategoryDetailsView extends StatelessWidget {
  const CategoryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Category Name",
          size: AppSizes.size18,
          color: AppColors.whiteColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 170,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            ),
          itemCount: 10, 
          itemBuilder: (BuildContext context, int index){
            return Container(
              height: 300,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.bgDarkColor,
                borderRadius: BorderRadius.circular(12),              
              ),
                            margin: EdgeInsets.only(right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    color: AppColors.blueColor,
                                    child: Image.asset(
                                      docsList[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                AppStyles.normal(title: docsNameList[index], alignment: TextAlign.center),
                                VxRating(
                                  selectionColor: AppColors.yellowColor,
                                  onRatingUpdate: (value){},
                                  maxRating: 5,
                                  count: 5,
                                  value: 4,
                                  stepInt: true,
                                )
                ],
              ),   
            );
          }
        ),
      ),
    );
  }
}