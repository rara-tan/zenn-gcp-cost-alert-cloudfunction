const slack = require('slack');

const BOT_ACCESS_TOKEN = process.env.BOT_ACCESS_TOKEN || '';
const CHANNEL = process.env.SLACK_CHANNEL || '';

exports.notifySlack = async pubsubEvent => {
  const pubsubAttrs = pubsubEvent.attributes;
  const pubsubData = Buffer.from(pubsubEvent.data, 'base64').toString();

  if (pubsubData.costAmount > pubsubData.budgetAmount) {
    await slack.chat.postMessage({
      token: BOT_ACCESS_TOKEN,
      channel: CHANNEL,
      text: `The cost of ${pubsubData.budgetDisplayName} has exceeded the budget`,
    });
    return 'Slack notification sent successfully';
  } else {
    return 'The cost is within the budget range';
  }
};
