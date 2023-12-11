import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth / constraints.maxHeight > 1.3) {
            return GridViewFAQ(columns: 2);
          }
          return GridViewFAQ(columns: 1);
        },
      ),
    );
  }
}

class GridViewFAQ extends StatelessWidget {
  final int columns;

  const GridViewFAQ({super.key, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(50),
        child: GridView.count(
          crossAxisCount: columns,
          children: const [
            FAQWidget(
              question: "What is a ward? Who is an alder?",
              answer:
                  '''The city of Chicago is divided into 50 legislative areas, called “wards”. Each ward contains roughly 50,000 residents and can overlap with multiple neighborhoods. Ward boundaries are redrawn every 8 years and were last redrawn in 2023.

Each ward elects an alder, who is essentially a mini-mayor. They provide ward services and vote on citywide legislation in the Chicago City Council.


Learn more about what an alder does: 
https://www.citybureau.org/newswire/2023/1/24/what-does-an-alderman-do

See the list of wards and current alders: 
https://www.chicago.gov/city/en/about/wards.html
                  ''',
            ),
            FAQWidget(
              question: "What are aldermanic menu funds?",
              answer: '''
“Every year, the City of Chicago allocates 'menu money' to each of the 50 alders to spend at their discretion on capital improvements within their ward. In the past, alders received \$1.32 million a year. In 2021, the amount increased to \$1.5 million.
    Menu money funds can only be spent on capital projects and not operating costs; for example, they can fund a public bench or street repaving, but it cannot fund an after-school program or snacks. Most broadly, the money can be spent on infrastructure projects on public land. This budget is the main source of funding local infrastructure improvements like:
                  - street repaving
                  - pedestrian safety projects
                  - lighting
                  - traffic calming, and 
                  - sidewalk repairs
”
Source: PB Chicago

Alders are provided a list of standard menu items they can implement across their ward. They can choose to spend money on projects that aren’t on the list too.
                  ''',
            ),
            FAQWidget(
              question: "What is participatory budgeting?",
              answer: '''
Participatory budgeting (PB) is a practice having the community directly decide how to spend public budgets. A typical PB process goes like this:
        1. Residents submit PB project ideas
        2. A group of volunteers evaluates the ideas based on need and feasibility
        3. Residents vote on the final list of ideas to determine which ideas get funding
        4. The ward office works with CDOT to implement the winning project ideas

Only a handful wards currently use PB budgeting, but that number is growing. Learn more about participatory budgeting in Chicago here:  https://www.participatepbchicago.org/pages/pbgeneralinfo
                  ''',
            ),
            FAQWidget(
              question:
                  "How can I influence menu funds and infrastructure spending in my ward?",
              answer: '''
Reach out to your ward office! 
You can use our Find My Ward tool to get their contact information. If your ward does participatory budgeting, ask how you can be involved. If not, don’t despair! You can still contact your alder to discuss your infrastructure idea (and ask them to consider participatory budgeting).

Two pieces of advice:
      1. Phone calls are generally more impactful than emails. 
      2. Try to find other people who care about the same issue. Convince them to contact your ward office too! Many voices have more influence than a single voice alone.

                  ''',
            ),
            FAQWidget(
              question: "Where does your data come from?",
              answer: '''
Since 2012, the Chicago Office of Budget and Management has published PDFs of itemized aldermanic menu spending to their Capital Improvement Archive. Our site is using raw data extracted from these PDFs by journalist Jake Smith.

Researcher John C. Ruf submitted a FOIA request to get aldermanic spending data going back to 2005. Those PDFs are available here. We hope to incorporate that data into our site in the near future.

The standard menu item descriptions and cost information comes from the 2023 Neighborhood Infrastructure Menu Program packet that was sent out to ward offices.

Download a CSV of the spending data (WIP)
                  ''',
            ),
            FAQWidget(
              question: "Can I get involved with Ward Wise?",
              answer: '''
Sure! Our data analysis and website source code are publicly available on GitHub. Ward Wise is a breakout group under Chi Hack Night. We meet every Tuesday night.
                  ''',
            ),
            FAQWidget(
              question: "Do you have new features planned for the site?",
              answer: '''
See our issues list on GitHub.
                  ''',
            ),
            FAQWidget(
              question: "I have another question not on this list.",
              answer: '''
Send us an email at wardwisechicago@gmail.com and we'll do our best to respond!
                  ''',
            ),
          ],
        ));
  }
}

class FAQCollapsableWidget extends StatelessWidget {
  final String answer;
  final String question;

  const FAQCollapsableWidget(
      {super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).cardColor,
      tilePadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      childrenPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      title: Text(question),
      children: <Widget>[Text(answer)],
    );
  }
}

class FAQWidget extends StatelessWidget {
  final String answer;
  final String question;

  const FAQWidget({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          question,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          answer,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
