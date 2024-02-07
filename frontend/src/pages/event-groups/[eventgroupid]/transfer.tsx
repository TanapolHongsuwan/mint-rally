import { NextPage } from "next";
import { useRouter } from "next/router";
import EventGroupBase from "src/components/organisms/EventGroupBase";
import { Box, Button, FormControl, FormLabel, Input, Select, Text, Tabs } from "@chakra-ui/react";
import { useForm, Controller } from "react-hook-form";
import { useLocale } from "src/hooks/useLocale";
import { useState } from "react";

interface FormData {
  address: string;
}

const TransferPage: NextPage = () => {
  const { t } = useLocale();
  const [tabIndex, setTabIndex] = useState(0);
  const router = useRouter();
  const { eventgroupid } = router.query;
  const { control, handleSubmit, formState: { errors } } = useForm<FormData>();

  const onSubmit = (data: FormData) => {
    console.log(data);
  };

  return (
    <EventGroupBase>
      {eventgroupid && (
        <form onSubmit={handleSubmit(onSubmit)}>
          <Tabs mt={5} index={tabIndex} onChange={(index) => setTabIndex(index)}>
            <FormControl mb={5}>
              <FormLabel htmlFor="address">{t.RBAC_WALLET_ADDRESS}</FormLabel>
              <Controller
                control={control}
                name="address"
                rules={{ required: true, pattern: /^0x[a-fA-F0-9]{40}$/ }}
                render={({ field }) => (
                  <Input
                    id="address"
                    onChange={field.onChange}
                    value={field.value}
                    maxLength={42}
                    placeholder={t.RBAC_INPUT_ADDRESS_TITLE}
                  />
                )}
              />
              {errors.address && <Text color="red.500">{t.RBAC_INPUT_ADDRESS_TITLE}</Text>}
            </FormControl>
            <Button
              type="submit"
              colorScheme="mintGreen"
              w="full"
            >
              {t.TRANSFER_OWNER}
            </Button>
          </Tabs>
        </form>
      )}
    </EventGroupBase>
  );
};

export default TransferPage;

