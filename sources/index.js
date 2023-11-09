const slack = require('slack');

const BOT_ACCESS_TOKEN = process.env.BOT_ACCESS_TOKEN || '';
const CHANNEL = process.env.SLACK_CHANNEL || '';

exports.notifySlack = async pubsubEvent => {
  const pubsubAttrs = pubsubEvent.attributes;
  const pubsubData = Buffer.from(pubsubEvent.data, 'base64').toString();
  const budgetNotificationText = `${JSON.stringify(
    pubsubAttrs
  )}, ${pubsubData}`;

  await slack.chat.postMessage({
    token: BOT_ACCESS_TOKEN,
    channel: CHANNEL,
    text: budgetNotificationText,
  });

  return 'Slack notification sent successfully';
};
